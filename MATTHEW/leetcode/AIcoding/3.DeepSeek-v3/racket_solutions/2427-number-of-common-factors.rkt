(define/contract (common-factors a b)
  (-> exact-integer? exact-integer? exact-integer?)
  (define (gcd x y)
    (if (= y 0)
        x
        (gcd y (modulo x y))))
  (let ([g (gcd a b)])
    (let loop ([i 1] [count 0])
      (if (> i g)
          count
          (if (and (= (modulo g i) 0))
              (loop (+ i 1) (+ count 1))
              (loop (+ i 1) count))))))