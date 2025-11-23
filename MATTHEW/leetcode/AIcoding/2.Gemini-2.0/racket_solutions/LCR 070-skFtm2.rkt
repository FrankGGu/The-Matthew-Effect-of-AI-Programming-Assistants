(define (single-non-duplicate nums)
  (let loop ([left 0] [right (- (length nums) 1)])
    (cond
      [(= left right) (list-ref nums left)]
      [else
       (let ([mid (floor (+ left right) 2)])
         (if (even? mid)
             (if (= (list-ref nums mid) (list-ref nums (+ mid 1)))
                 (loop (+ mid 2) right)
                 (loop left mid))
             (if (= (list-ref nums mid) (list-ref nums (- mid 1)))
                 (loop (+ mid 1) right)
                 (loop left (- mid 1)))))])))