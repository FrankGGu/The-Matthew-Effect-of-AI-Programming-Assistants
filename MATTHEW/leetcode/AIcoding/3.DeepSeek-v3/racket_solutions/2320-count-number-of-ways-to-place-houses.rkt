(define/contract (count-house-placement n)
  (-> exact-integer? exact-integer?)
  (define mod 1000000007)
  (cond
    [(= n 1) 4]
    [(= n 2) 9]
    [else
     (let loop ([i 3] [a 2] [b 3])
       (if (> i n)
           (modulo (* (+ a b) (+ a b)) mod)
           (loop (add1 i) b (modulo (+ a b) mod))))])