(define (peak-index-in-mountain-array arr)
  (let loop ([l 0] [r (- (length arr) 1)])
    (if (= l r)
        l
        (let ([mid (quotient (+ l r) 2)])
          (if (> (list-ref arr mid) (list-ref arr (+ mid 1)))
              (loop l mid)
              (loop (+ mid 1) r))))))