(define/contract (check-powers-of-three n)
  (-> exact-integer? boolean?)
  (let loop ([n n] [k 0])
    (cond
      [(zero? n) #t]
      [(< n 0) #f]
      [else
       (let ([remainder (modulo n 3)])
         (cond
           [(= remainder 2) #f]
           [else (loop (quotient n 3) (+ k 1))]))])))