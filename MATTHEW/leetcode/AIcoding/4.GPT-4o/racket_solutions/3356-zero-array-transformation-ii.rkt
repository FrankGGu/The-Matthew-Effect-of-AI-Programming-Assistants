(define (can-transform-to-zero arr)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define total-sum (apply + arr))
  (define overall-gcd (apply gcd arr))

  (if (= overall-gcd 0)
      (zero? total-sum)
      (= (modulo total-sum overall-gcd) 0)))

(define (zeroArrayTransformation arr)
  (can-transform-to-zero arr))