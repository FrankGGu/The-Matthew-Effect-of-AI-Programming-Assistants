(define (flip-lights n m)
  (let ([n (min n 3)])
    (cond
      [(= m 0) 1]
      [(= n 1) 2]
      [(= n 2) (if (= m 1) 3 (if (>= m 2) 4 0))]
      [else (if (= m 1) 4 (if (= m 2) 7 (if (>= m 3) 8 0)))])))