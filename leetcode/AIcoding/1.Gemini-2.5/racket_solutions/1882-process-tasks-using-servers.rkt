#lang racket

(define (process-tasks-using-servers servers tasks)
  ;; Min-heap implementation
  ;; Stores elements in a mutable vector. `size` tracks current number of elements.
  ;; `heap-comp` is a comparison function: (elem1 elem2) -> boolean (true if elem1 is "smaller")

  (struct heap (data size comp) #:mutable #:transparent)

  (define (make-heap comp initial-capacity)
    (heap (make-vector initial-capacity) 0 comp))

  (define (heap-empty? h)
    (zero? (heap-size h)))

  (define (heap-peek h)
    (when (heap-empty? h)
      (error "heap-peek on empty heap"))
    (vector-ref (heap-data h) 0))

  ;; Doubles the capacity of the heap's underlying vector when full.
  (define (heap-ensure-capacity! h)
    (let* ([data (heap-data h)]
           [current-capacity (vector-length data)])
      (when (= (heap-size h) current-capacity)
        (let ([new-capacity (if (zero? current-capacity) 16 (* current-capacity 2))])
          (let ([new-data (make-vector new-capacity)])
            (for ([i (in-range (heap-size h))])
              (vector-set! new-data i (vector-ref data i)))
            (set-heap-data! h new-data))))))

  ;; Adds an element to the heap, maintaining heap property (bubble up).
  (define (heap-push! h elem)
    (heap-ensure-capacity! h)
    (let* ([data (heap-data h)]
           [comp (heap-comp h)]
           [idx (heap-size h)])
      (vector-set! data idx elem)
      (set-heap-size! h (+ idx 1))
      (let loop ([current-idx idx])
        (if (zero? current-idx)
            #f
            (let* ([parent-idx (floor (/ (- current-idx 1) 2))])
              (when (comp elem (vector-ref data parent-idx))
                (vector-set! data current-idx (vector-ref data parent-idx))
                (vector-set! data parent-idx elem)
                (loop parent-idx)))))))

  ;; Removes and returns the smallest element from the heap, maintaining heap property (bubble down).
  (define (heap-pop! h)
    (when (heap-empty? h)
      (error "heap-pop! on empty heap"))
    (let* ([data (heap-data h)]
           [comp (heap-comp h)]
           [len (heap-size h)]
           [root (vector-ref data 0)])
      (set-heap-size! h (- len 1))
      (let ([last-idx (heap-size h)]) ; New last index
        (when (> len 1)
          (vector-set! data 0 (vector-ref data last-idx))
          (let loop ([current-idx 0])
            (let* ([left-child-idx (+ (* 2 current-idx) 1)]
                   [right-child-idx (+ (* 2 current-idx) 2)]
                   [smallest-idx current-idx])
              ;; Find smallest among current, left, right
              (when (< left-child-idx (heap-size h))
                (when (comp (vector-ref data left-child-idx) (vector-ref data smallest-idx))
                  (set! smallest-idx left-child-idx)))
              (when (< right-child-idx (heap-size h))
                (when (comp (vector-ref data right-child-idx) (vector-ref data smallest-idx))
                  (set! smallest-idx right-child-idx)))

              (if (not (= smallest-idx current-idx))
                  (begin
                    ;; Swap
                    (let ([temp (vector-ref data current-idx)])
                      (vector-set! data current-idx (vector-ref data smallest-idx))
                      (vector-set! data smallest-idx temp))
                    (loop smallest-idx))
                  #f))))
      root))

  ;; Comparison function for available servers: (weight, index)
  ;; Prioritizes smaller weight, then smaller index.
  (define (server-comp s1 s2)
    (let ([w1 (car s1)] [i1 (cadr s1)]
          [w2 (car s2)] [i2 (cadr s2)])
      (or (< w1 w2)
          (and (= w1 w2) (< i1 i2)))))

  ;; Comparison function for busy servers: (finish-time, weight, index)
  ;; Prioritizes earlier finish-time, then smaller weight, then smaller index.
  (define (busy-server-comp bs1 bs2)
    (let ([f1 (car bs1)] [w1 (cadr bs1)] [i1 (caddr bs1)]
          [f2 (car bs2)] [w2 (cadr bs2)] [i2 (caddr bs2)])
      (or (< f1 f2)
          (and (= f1 f2) (< w1 w2))
          (and (= f1 f2) (= w1 w2) (< i1 i2)))))

  ;; Convert input lists to vectors for O(1) access.
  (define server-weights-vec (list->vector servers))
  (define task-times-vec (list->vector tasks))

  ;; Initialize heaps for available and busy servers.
  (define n (vector-length server-weights-vec))
  (define available-servers (make-heap server-comp n))
  (define busy-servers (make-heap busy-server-comp n))

  ;; Populate available-servers initially with all servers.
  (for ([w (in-vector server-weights-vec)] [i (in-range n)])
    (heap-push! available-servers (list w i)))

  ;; Result array to store assigned server indices for each task.
  (define m (vector-length task-times-vec))
  (define ans (make-vector m))

  (define current-time 0)

  ;; Helper function to move all currently freed servers from busy to available heap.
  (define (free-up-servers!)
    (let loop ()
      (when (and (not (heap-empty? busy-servers))
                 (<= (car (heap-peek busy-servers)) current-time))
        (let ([freed-server-info (heap-pop! busy-servers)])
          (heap-push! available-servers (list (cadr freed-server-info) (caddr freed-server-info)))
          (loop)))))

  ;; Process each task in order of arrival.
  (for ([task-idx (in-range m)])
    ;; Advance current-time to at least the arrival time of the current task.
    (set! current-time (max current-time task-idx))

    ;; Free up any servers that have finished their tasks by current-time.
    (free-up-servers!)

    ;; If no servers are available, wait for the next server to become free.
    (when (heap-empty? available-servers)
      (let* ([next-free-server-info (heap-peek busy-servers)]
             [next-free-time (car next-free-server-info)])
        ;; Advance current-time to when the next server frees up.
        (set! current-time next-free-time)
        ;; After advancing time, free up all servers that are now available.
        (free-up-servers!)))

    ;; Assign the current task to the best available server.
    (let ([assigned-server-info (heap-pop! available-servers)])
      (let ([weight (car assigned-server-info)]
            [server-idx (cadr assigned-server-info)])
        (vector-set! ans task-idx server-idx)
        (let ([task-processing-time (vector-ref task-times-vec task-idx)])
          (let ([finish-time (+ current-time task-processing-time)])
            ;; Put the server into the busy heap with its new finish time.
            (heap-push! busy-servers (list finish-time weight server-idx)))))))

  ;; Convert the result vector to a list as expected by LeetCode Racket solutions.
  (vector->list ans))