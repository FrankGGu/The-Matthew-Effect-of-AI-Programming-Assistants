(define (insert-greatest-common-divisors head)
  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (remainder a b))))
  (define (insert node)
    (if (not (pair? node))
        null
        (let* ((next (cdr node))
               (val (car node))
               (next-val (if (pair? next) (car next) 0))
               (g (gcd val next-val)))
          (cons val (cons g (insert next))))))
  (insert head))