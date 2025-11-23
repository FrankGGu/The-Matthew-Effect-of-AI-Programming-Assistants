(define (find-min nums)
  (let loop ([l 0] [r (- (length nums) 1)])
    (cond
      [(< l r)
       (let ([mid (quotient (+ l r) 2)])
         (cond
           [(< (list-ref nums mid) (list-ref nums r))
            (loop l mid)]
           [else
            (loop (+ mid 1) r)]))]
      [else
       (list-ref nums l)])))