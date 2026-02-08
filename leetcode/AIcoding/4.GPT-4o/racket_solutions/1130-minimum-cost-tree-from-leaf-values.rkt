(define (mctFromLeafValues arr)
  (define (helper arr)
    (if (null? arr)
        0
        (let loop ((arr arr) (total 0))
          (if (null? (cdr arr))
              total
              (let* ((min-val (apply min arr))
                     (min-index (index-of arr min-val))
                     (left (sublist arr 0 min-index))
                     (right (sublist arr (+ min-index 1))))
                (loop (append left right) (+ total (* min-val (if (null? left) (car right) (if (null? right) (car left) (max (car left) (car right))))))))))))
  (helper arr))