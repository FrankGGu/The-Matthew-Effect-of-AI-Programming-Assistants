(define (closestDivisors n)
  (define (find-divisors m)
    (for/fold ([closest '()])
               ([i (in-range 1 (add1 (sqrt m)))])
      (when (= (remainder m i) 0)
        (set! closest (if (null? closest)
                          (list i (quotient m i))
                          (let ([a (car closest)]
                                [b (cadr closest)])
                            (if (< (abs (- a b)) (abs (- i (quotient m i))))
                                closest
                                (list i (quotient m i)))))))
    closest))

  (let ([d1 (find-divisors (+ n 1))])
    (if (null? d1)
        (find-divisors (+ n 2))
        d1)))