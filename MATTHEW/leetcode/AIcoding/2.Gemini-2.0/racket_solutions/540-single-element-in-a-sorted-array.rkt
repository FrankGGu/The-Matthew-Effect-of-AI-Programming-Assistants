(define (single-non-duplicate nums)
  (let loop ([l 0] [r (- (length nums) 1)])
    (cond
      [(= l r) (list-ref nums l)]
      [else
       (let ([mid (floor (/ (+ l r) 2))])
         (if (even? mid)
             (if (= (list-ref nums mid) (list-ref nums (+ mid 1)))
                 (loop (+ mid 2) r)
                 (loop l mid))
             (if (= (list-ref nums mid) (list-ref nums (- mid 1)))
                 (loop (+ mid 1) r)
                 (loop l (- mid 1)))))])))