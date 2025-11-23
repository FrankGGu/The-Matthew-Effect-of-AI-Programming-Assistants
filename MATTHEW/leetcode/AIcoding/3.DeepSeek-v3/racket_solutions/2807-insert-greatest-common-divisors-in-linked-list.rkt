(define/contract (insert-greatest-common-divisors head)
  (-> (or/c list? null?) (or/c list? null?))
  (define (gcd a b)
    (if (zero? b)
        a
        (gcd b (modulo a b))))
  (if (null? head)
      null
      (let loop ([prev (car head)]
                 [rest (cdr head)]
                 [result (list (car head))])
        (if (null? rest)
            (reverse result)
            (let* ([curr (car rest)]
                   [g (gcd prev curr)])
              (loop curr (cdr rest) (cons curr (cons g result)))))))