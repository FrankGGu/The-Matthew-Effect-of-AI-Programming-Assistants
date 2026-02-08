(define (number-of-strings n)
  (define MOD 1000000007)

  (define (pow-mod base exp modulus)
    (define (iter b e res)
      (cond
        [(= e 0) res]
        [(odd? e) (iter (modulo (* b b) modulus) (quotient e 2) (modulo (* res b) modulus))]
        [else (iter (modulo (* b b) modulus) (quotient e 2) res)]))
    (iter base exp 1))

  (define term-3-pow-n (pow-mod 3 n MOD))
  (define term-2-pow-n (pow-mod 2 n MOD))

  (define three-times-2-pow-n (modulo (* 3 term-2-pow-n) MOD))

  (define three-times-1-pow-n 3)

  (define result (- term-3-pow-n three-times-2-pow-n))
  (set! result (modulo result MOD))
  (when (< result 0)
    (set! result (+ result MOD)))

  (set! result (+ result three-times-1-pow-n))
  (set! result (modulo result MOD))
  (when (< result 0)
    (set! result (+ result MOD)))

  result)