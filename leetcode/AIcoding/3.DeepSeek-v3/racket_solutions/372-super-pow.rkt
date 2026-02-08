(define (super-pow a b)
  (define (pow-mod a b mod)
    (cond
      [(= b 0) 1]
      [(even? b) (modulo (sqr (pow-mod a (/ b 2) mod)) mod)]
      [else (modulo (* a (pow-mod a (- b 1) mod)) mod])))

  (define (helper a b mod)
    (if (null? b)
        1
        (let* ([last-digit (last b)]
               [rest (drop-right b 1)]
               [part1 (pow-mod a last-digit mod)]
               [part2 (pow-mod (helper a rest mod) 10 mod)])
          (modulo (* part1 part2) mod))))

  (helper a b 1337))