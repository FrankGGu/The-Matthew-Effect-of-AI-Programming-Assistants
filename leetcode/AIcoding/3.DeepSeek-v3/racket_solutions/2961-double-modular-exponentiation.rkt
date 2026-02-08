(define/contract (power-mod a b mod)
  (-> exact-integer? exact-integer? exact-integer? exact-integer?)
  (cond
    [(= b 0) 1]
    [(even? b) (modulo (sqr (power-mod a (quotient b 2) mod)) mod)]
    [else (modulo (* a (power-mod a (sub1 b) mod)) mod)]))

(define/contract (get-good-indices variables k)
  (-> (listof (listof exact-integer?)) exact-integer? (listof exact-integer?))
  (let loop ([i 0] [vars variables] [res '()])
    (if (null? vars)
        (reverse res)
        (let* ([var (car vars)]
               [a (first var)]
               [b (second var)]
               [c (third var)]
               [m (fourth var)]
               [x (power-mod a b 10)]
               [y (power-mod x c m)])
          (if (= (modulo y m) k)
              (loop (add1 i) (cdr vars) (cons i res))
              (loop (add1 i) (cdr vars) res))))))