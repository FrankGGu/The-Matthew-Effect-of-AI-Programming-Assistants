(require racket/vector)
(require racket/list)
(require racket/sort)

(define (min-interval intervals queries)
  ;; --- Min-Heap Implementation ---
  ;; Stores elements as (value, secondary-value) tuples.
  ;; Compares primarily by 'value'.
  (define (make-min-heap)
    (let ((heap (make-vector 0)))
      (define (heap-size) (vector-length heap))

      (define (parent i) (quotient (- i 1) 2))
      (define (left-child i) (+ (* 2 i) 1))
      (define (right-child i) (+ (* 2 i) 2))

      (define (swap i j)
        (let ((temp (vector-ref heap i)))
          (vector-set! heap i (vector-ref heap j))
          (vector-set! heap j temp)))

      (define (heapify-up i)
        (let loop ((idx i))
          (let ((p (parent idx)))
            (when (and (> idx 0) (< (car (vector-ref heap idx)) (car (vector-ref heap p))))
              (swap idx p)
              (loop p)))))

      (define (heapify-down i)
        (let loop ((idx i))
          (let* ((l (left-child idx))
                 (r (right-child idx))
                 (smallest idx))
            (when (and (< l (heap-size)) (< (car (vector-ref heap l)) (car (vector-ref heap smallest))))
              (set! smallest l))
            (when (and (< r (heap-size)) (< (car (vector-ref heap r)) (car (vector-ref heap smallest))))
              (set! smallest r))
            (when (not (= smallest idx))
              (swap idx smallest)
              (loop smallest)))))

      (define (heap-insert val)
        (set! heap (vector-append heap (vector val)))
        (heapify-up (- (heap-size) 1)))

      (define (heap-extract-min)
        (when (zero? (heap-size))
          (error "Heap is empty"))
        (let ((min-val (vector-ref heap 0)))
          (when (> (heap-size) 1)
            (swap 0 (- (heap-size) 1)))
          (set! heap (vector-drop-right heap 1))
          (when (> (heap-size) 0)
            (heapify-down 0))
          min-val))

      (define (heap-peek-min)
        (when (zero? (heap-size))
          (error "Heap is empty"))
        (vector-ref heap 0))

      (define (heap-empty?)
        (zero? (heap-size)))

      (list heap-insert heap-extract-min heap-peek-min heap-empty?)))

  ;; --- Main Logic for Minimum Interval to Include Each Query ---
  (let* ((num-queries (length queries))
         (ans (make-vector num-queries -1))
         ;; Pair queries with their original indices and sort them by query value
         (indexed-queries (map (lambda (q i) (list q i)) queries (range num-queries)))
         (sorted-queries (sort indexed-queries < #:key car))
         ;; Sort intervals by their start points
         (sorted-intervals (sort intervals < #:key car)))

    ;; Destructure heap functions
    (let-values (((heap-insert heap-extract-min heap-peek-min heap-empty?) (make-min-heap)))
      (let loop ((q-idx 0) (interval-ptr 0)) ; q-idx for sorted-queries, interval-ptr for sorted-intervals
        (when (< q-idx num-queries)
          (let* ((current-query-pair (list-ref sorted-queries q-idx))
                 (q-val (car current-query-pair))
                 (original-idx (cadr current-query-pair)))

            ;; 1. Add new intervals to the heap:
            ;;    Add all intervals [L, R] such that L <= current query value.
            (let loop-add ((i interval-ptr))
              (if (and (< i (length sorted-intervals))
                       (<= (car (list-ref sorted-intervals i)) q-val))
                  (let* ((interval (list-ref sorted-intervals i))
                         (L (car interval))
                         (R (cadr interval)))
                    ;; Store (length, end-point) in the heap
                    (heap-insert (list (- R L -1) R))
                    (loop-add (+ i 1)))
                  i)) ; Return the updated interval-ptr
            (set! interval-ptr (loop-add interval-ptr))

            ;; 2. Remove expired intervals from the heap:
            ;;    Remove intervals whose end-point < current query value.
            (let loop-remove ()
              (when (and (not (heap-empty?))
                         (< (cadr (heap-peek-min)) q-val)) ; Check end-point
                (heap-extract-min)
                (loop-remove)))

            ;; 3. Get the minimum length for the current query:
            ;;    If the heap is not empty, the top element has the minimum length.
            (when (not (heap-empty?))
              (vector-set! ans original-idx (car (heap-peek-min))))

            ;; Continue to the next query
            (loop (+ q-idx 1) interval-ptr)))))

    (vector->list ans)))