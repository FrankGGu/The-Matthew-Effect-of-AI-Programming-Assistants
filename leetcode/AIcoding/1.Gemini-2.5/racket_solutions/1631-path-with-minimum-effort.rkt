#lang racket

(define (minimum-effort-path heights-list-of-lists)
  ;; Convert heights from list of lists to vector of vectors for efficient access
  (define m (length heights-list-of-lists))
  (define n (length (car heights-list-of-lists)))

  (define heights (make-vector m))
  (for ([i (in-range m)]
        [row-list heights-list-of-lists])
    (vector-set! heights i (list->vector row-list)))

  (define infinity (add1 1000000)) ; Max possible effort is 10^6, so 10^6 + 1 is safe infinity

  ;; min-effort grid, initialized to infinity
  (define min-effort (make-vector m))
  (for ([i (in-range m)])
    (vector-set! min-effort i (make-vector n infinity)))

  (vector-set! (vector-ref min-effort 0) 0 0)

  ;; --- Priority Queue (Min-Heap) Implementation ---
  ;; Heap stores (list effort r c)
  ;; Initial capacity: Maximum number of edges (E) is 4*m*n.
  ;; In worst case, each edge might push an item. So, E is a good upper bound for total pushes.
  (define pq-capacity (* m n 4))
  (define pq-data (make-vector pq-capacity #f)) ; #f as placeholder
  (define pq-size 0)

  ;; Helper to swap elements in the heap vector
  (define (swap! vec i j)
    (let ([temp (vector-ref vec i)])
      (vector-set! vec i (vector-ref vec j))
      (vector-set! vec j temp)))

  ;; Heapify up
  (define (heap-bubble-up! idx)
    (let loop ([current-idx idx])
      (when (> current-idx 0)
        (let* ([parent-idx (floor (/ (- current-idx 1) 2))]
               [current-item (vector-ref pq-data current-idx)]
               [parent-item (vector-ref pq-data parent-idx)])
          (when (< (car current-item) (car parent-item)) ; Compare effort
            (swap! pq-data current-idx parent-idx)
            (loop parent-idx))))))

  ;; Heapify down
  (define (heap-bubble-down! idx)
    (let loop ([current-idx idx])
      (let* ([left-child-idx (+ (* 2 current-idx) 1)]
             [right-child-idx (+ (* 2 current-idx) 2)]
             [smallest-idx current-idx])

        (when (and (< left-child-idx pq-size)
                   (< (car (vector-ref pq-data left-child-idx))
                      (car (vector-ref pq-data smallest-idx))))
          (set! smallest-idx left-child-idx))

        (when (and (< right-child-idx pq-size)
                   (< (car (vector-ref pq-data right-child-idx))
                      (car (vector-ref pq-data smallest-idx))))
          (set! smallest-idx right-child-idx))

        (when (!= smallest-idx current-idx)
          (swap! pq-data current-idx smallest-idx)
          (loop smallest-idx))))))

  ;; Resize heap vector if capacity is reached
  (define (pq-resize!)
    (set! pq-capacity (* pq-capacity 2))
    (let ([new-pq-data (make-vector pq-capacity #f)])
      (for ([i (in-range pq-size)])
        (vector-set! new-pq-data i (vector-ref pq-data i)))
      (set! pq-data new-pq-data)))

  ;; Push item to PQ
  (define (pq-push! item)
    (when (= pq-size pq-capacity)
      (pq-resize!))
    (vector-set! pq-data pq-size item)
    (set! pq-size (add1 pq-size))
    (heap-bubble-up! (sub1 pq-size)))

  ;; Pop item from PQ
  (define (pq-pop!)
    (when (zero? pq-size)
      (error "Priority queue is empty"))
    (let ([min-item (vector-ref pq-data 0)])
      (set! pq-size (sub1 pq-size))
      (when (> pq-size 0)
        (vector-set! pq-data 0 (vector-ref pq-data pq-size))
        (heap-bubble-down! 0))
      min-item))

  ;; Check if PQ is empty
  (define (pq-empty?)
    (zero? pq-size))
  ;; --- End Priority Queue Implementation ---

  ;; Directions for neighbors
  (define dr (list -1 1 0 0))
  (define dc (list 0 0 -1 1))

  ;; Initial push
  (pq-push! (list 0 0 0)) ; (effort row col)

  (define target-r (sub1 m))
  (define target-c (sub1 n))

  (let loop ()
    (unless (pq-empty?)
      (let* ([current-item (pq-pop!)]
             [current-effort (car current-item)]
             [r (cadr current-item)]
             [c (caddr current-item)])

        ;; Optimization: If we've already found a better path to (r,c), skip.
        ;; This is crucial for Dijkstra's efficiency.
        (when (> current-effort (vector-ref (vector-ref min-effort r) c))
          (loop))

        ;; Check neighbors
        (for ([i (in-range 4)])
          (let* ([nr (+ r (list-ref dr i))]
                 [nc (+ c (list-ref dc i))])

            (when (and (>= nr 0) (< nr m)
                       (>= nc 0) (< nc n))
              (let* ([height-r-c (vector-ref (vector-ref heights r) c)]
                     [height-nr-nc (vector-ref (vector-ref heights nr) nc)]
                     [height-diff (abs (- height-r-c height-nr-nc))]
                     [new-effort (max current-effort height-diff)])

                (when (< new-effort (vector-ref (vector-ref min-effort nr) nc))
                  (vector-set! (vector-ref min-effort nr) nc new-effort)
                  (pq-push! (list new-effort nr nc)))))))
      (loop)))

  (vector-ref (vector-ref min-effort target-r) target-c))