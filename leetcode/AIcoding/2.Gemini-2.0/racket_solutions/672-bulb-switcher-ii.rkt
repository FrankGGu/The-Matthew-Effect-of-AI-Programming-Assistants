(define (flip-bulbs n p)
  (cond
    [(zero? n) 1]
    [(zero? p) 1]
    [else
     (let ([m (min n 3)])
       (cond
         [(= m 1) 2]
         [(= m 2) (if (>= p 1) 4 1)]
         [else (cond
                 [(>= p 1) 8]
                 [else 1])]))]))