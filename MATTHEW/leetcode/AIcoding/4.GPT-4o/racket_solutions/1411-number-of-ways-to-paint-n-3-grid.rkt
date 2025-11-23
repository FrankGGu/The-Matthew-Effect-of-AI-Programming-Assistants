(define (numOfWays n)
  (define mod 1000000007)
  (define a 6)
  (define b 6)

  (define (pow x y)
    (if (= y 0)
        1
        (modulo (* x (pow x (- y 1))) mod)))

  (for ([i (in-range (- n 1))])
    (let ([temp a])
      (set! a (modulo (+ (* 3 a) (* (- b) 2)) mod))
      (set! b (modulo (+ (* 2 temp) (* b 2)) mod))))

  (modulo (+ a b) mod))

(numOfWays)