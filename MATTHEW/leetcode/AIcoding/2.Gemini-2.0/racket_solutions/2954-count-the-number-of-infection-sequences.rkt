(define (count-infection-sequences n)
  (define mod 1000000007)
  (define (factorial n)
    (let loop ((i n) (acc 1))
      (if (= i 0)
          acc
          (loop (- i 1) (modulo (* acc i) mod)))))
  (define (power x y)
    (let loop ((b x) (e y) (acc 1))
      (cond
        ((= e 0) acc)
        ((even? e) (loop (modulo (* b b) mod) (/ e 2) acc))
        (else (loop b (- e 1) (modulo (* acc b) mod))))))
  (define (inverse a)
    (power a (- mod 2)))
  (define (combinations n k)
    (if (or (< k 0) (> k n))
        0
        (modulo (* (factorial n)
                 (modulo (* (inverse (factorial k))
                          (inverse (factorial (- n k)))) mod)) mod)))

  (if (= n 1)
      1
      (modulo (* (factorial n)
               (combinations (- (* 2 n) 2) (- n 1))) mod)))