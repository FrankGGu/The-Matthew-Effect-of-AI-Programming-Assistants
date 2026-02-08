(define (maximum-eaten-apples apples days)

  ;; Min-heap implementation using a mutable vector
  ;; Each element in the heap is a pair (expiration-day . count)
  ;; Comparison is based on expiration-day (car of the pair)

  (struct heap (vec size) #:mutable)

  (define (make-heap)
    (heap (make-vector 10 #f) 0)) ; Initial capacity 10, fill with #f

  (define (heap-empty? h)
    (= (heap-size h) 0))

  (define (heap-peek h)
    (if (heap-empty? h)
        #f
        (vector-ref (heap-vec h) 0)))

  (define (heap-parent i) (floor (/ (- i 1) 2)))
  (define (heap-left i) (+ (* 2 i) 1))
  (define (heap-right i) (+ (* 2 i) 2)))

  ;; Grows the underlying vector if capacity is reached
  (define (heap-grow h)
    (let* ((old-vec (heap-vec h))
           (old-size (heap-size h))
           (old-capacity (vector-length old-vec))
           (new-capacity (if (= old-capacity 0) 10 (* 2 old-capacity)))
           (new-vec (make-vector new-capacity #f)))
      (for ((i (in-range old-size)))
        (vector-set! new-vec i (vector-ref old-vec i)))
      (set-heap-vec! h new-vec)))

  ;; Sift up an element at index idx in the heap's vector
  (define (heap-sift-up! h idx)
    (let* ((vec (heap-vec h)))
      (let loop ((i idx))
        (let ((p (heap-parent i)))
          (when (and (> i 0) (< (car (vector-ref vec i)) (car (vector-ref vec p))))
            (let ((temp (vector-ref vec i)))
              (vector-set! vec i (vector-ref vec p))
              (vector-set! vec p temp))
            (loop p))))))

  ;; Sift down an element at index idx in the heap's vector
  (define (heap-sift-down! h idx)
    (let* ((vec (heap-vec h))
           (len (heap-size h))) ; Use heap-size for effective length
      (let loop ((i idx))
        (let* ((l (heap-left i))
               (r (heap-right i))
               (smallest i))
          (when (and (< l len) (< (car (vector-ref vec l)) (car (vector-ref vec smallest))))
            (set! smallest l))
          (when (and (< r len) (< (car (vector-ref vec r)) (car (vector-ref vec smallest))))
            (set! smallest r))
          (when (not (= smallest i))
            (let ((temp (vector-ref vec i)))
              (vector-set! vec i (vector-ref vec smallest))
              (vector-set! vec smallest temp))
            (loop smallest))))))

  ;; Inserts an item into the heap
  (define (heap-insert! h item)
    (let ((current-size (heap-size h)))
      (when (= current-size (vector-length (heap-vec h)))
        (heap-grow h))
      (vector-set! (heap-vec h) current-size item)
      (set-heap-size! h (+ current-size 1))
      (heap-sift-up! h (- (heap-size h) 1))))

  ;; Removes and returns the minimum item from the heap
  (define (heap-pop! h)
    (if (heap-empty? h)
        #f
        (let* ((vec (heap-vec h))
               (size (heap-size h))
               (min-item (vector-ref vec 0)))
          (set-vector-ref! vec 0 (vector-ref vec (- size 1))) ; Move last to first
          (set-heap-size! h (- size 1))
          (heap-sift-down! h 0)
          min-item)))

  ;; Main solution logic
  (let* ((n (vector-length apples))
         (pq (make-heap))
         (max-possible-day (for/fold ((m 0)) ((i (in-range n)))
                               (max m (+ i (vector-ref days i))))))

    (let loop ((day 0) (eaten-count 0))
      (cond
        ;; Termination condition: no more apples to add AND PQ is empty
        ((and (> day max-possible-day) (heap-empty? pq))
         eaten-count)

        (else
         ;; 1. Add new apples for current day
         (when (< day n)
           (let ((num-apples (vector-ref apples day))
                 (days-to-last (vector-ref days day)))
             (when (> num-apples 0)
               ;; Apple expires on day `day + days-to-last`
               (heap-insert! pq (cons (+ day days-to-last) num-apples)))))

         ;; 2. Remove expired apples from PQ
         (let remove-expired-loop ()
           (when (and (not (heap-empty? pq))
                      (<= (car (heap-peek pq)) day)) ; Apple expires on or before current day
             (heap-pop! pq)
             (remove-expired-loop)))

         ;; 3. Eat an apple if available
         (if (not (heap-empty? pq))
             (let* ((earliest-apple (heap-pop! pq))
                    (exp-day (car earliest-apple))
                    (count (cdr earliest-apple)))
               (when (> count 1)
                 (heap-insert! pq (cons exp-day (- count 1))))
               (loop (+ day 1) (+ eaten-count 1)))
             ;; No apple to eat, just advance day
             (loop (+ day 1) eaten-count)))))))