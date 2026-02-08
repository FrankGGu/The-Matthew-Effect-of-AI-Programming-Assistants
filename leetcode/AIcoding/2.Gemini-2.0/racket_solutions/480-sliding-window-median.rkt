(define (sliding-window-median nums k)
  (define n (length nums))
  (define (make-heap) (make-heap <))
  (define (make-heap>) (make-heap >))
  (define low-heap (make-heap>))
  (define high-heap (make-heap))
  (define result (make-vector (- n k -1)))

  (define (rebalance)
    (cond [(> (heap-count low-heap) (heap-count high-heap) 1)
           (heap-add! high-heap (heap-remove-min! low-heap))]
          [(> (heap-count high-heap) (heap-count low-heap))
           (heap-add! low-heap (heap-remove-min! high-heap))]))

  (define (add-num num)
    (if (or (zero? (heap-count low-heap))
            (<= num (heap-peek-min low-heap)))
        (heap-add! low-heap num)
        (heap-add! high-heap num))
    (rebalance))

  (define (remove-num num)
    (define (remove-from-heap heap num)
      (define temp-heap (make-heap (heap-comparator heap)))
      (let loop ([items (heap-items heap)])
        (cond [(null? items)
               (begin
                 (for ([item (heap-items temp-heap)])
                   (heap-add! heap item))
                 #t)]
              [(= (car items) num)
               (begin
                 (for ([item (cdr items)])
                   (heap-add! temp-heap item))
                 (for ([item (heap-items temp-heap)])
                   (heap-add! heap item))
                 #t)]
              [else
               (begin
                 (heap-add! temp-heap (car items))
                 (loop (cdr items)))])))

    (if (<= num (heap-peek-min low-heap))
        (remove-from-heap low-heap num)
        (remove-from-heap high-heap num))
    (rebalance))

  (for ([i (in-range k)])
    (add-num (vector-ref nums i)))

  (for ([i (in-range (- n k -1))])
    (vector-set! result i
                 (if (even? k)
                     (/ (+ (heap-peek-min low-heap) (heap-peek-min high-heap)) 2.0)
                     (heap-peek-min low-heap)))
    (remove-num (vector-ref nums i))
    (add-num (vector-ref nums (+ i k))))

  (vector-set! result (- n k -1)
               (if (even? k)
                   (/ (+ (heap-peek-min low-heap) (heap-peek-min high-heap)) 2.0)
                   (heap-peek-min low-heap)))

  (vector->list result))