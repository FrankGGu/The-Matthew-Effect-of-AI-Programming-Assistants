(define (mirror-reflection p q)
  (let loop ([m 1] [n 1])
    (cond [(equal? (* m p) (* n q))
           (cond [(even? m) 0]
                 [(odd? n) 1]
                 [else 2])]
          [else (if (< (* m p) (* n q))
                    (loop (+ m 1) n)
                    (loop m (+ n 1)))])))