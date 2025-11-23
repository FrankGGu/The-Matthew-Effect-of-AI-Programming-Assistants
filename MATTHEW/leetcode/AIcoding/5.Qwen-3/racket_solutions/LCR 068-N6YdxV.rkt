(define (search-insert nums target)
  (let loop ((left 0) (right (sub1 (length nums))))
    (if (> left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (< (list-ref nums mid) target)
              (loop (+ mid 1) right)
              (loop left (- mid 1)))))))