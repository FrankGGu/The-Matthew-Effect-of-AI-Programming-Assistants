(define (minHeightShelves books shelf_width)
  (define n (length books))
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  (define (max-height books start end)
    (if (= start end) 0
      (let loop ((i start) (width 0) (max-height 0))
        (if (>= i end) max-height
          (let ((book (list-ref books i)))
            (if (<= (+ width (car book)) shelf_width)
                (loop (+ i 1) (+ width (car book)) (max max-height (cdr book)))
                (loop (+ i 1) (car book) (cdr book)))))))

  (for ((i (in-range n)))
    (for ((j (in-range i +1))) 
      (let ((height (max-height books j (add1 i))))
        (vector-set! dp (add1 i) (min (vector-ref dp (add1 i)) (+ (vector-ref dp j) height))))))

  (vector-ref dp n))