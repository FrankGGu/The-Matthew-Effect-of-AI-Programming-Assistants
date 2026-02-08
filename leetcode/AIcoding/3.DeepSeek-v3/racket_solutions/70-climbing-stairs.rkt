(define/contract (climb-stairs n)
  (-> exact-integer? exact-integer?)
  (cond
    [(= n 1) 1]
    [(= n 2) 2]
    [else
     (let loop ([a 1] [b 2] [i 3])
       (if (> i n)
           b
           (loop b (+ a b) (add1 i))))]))