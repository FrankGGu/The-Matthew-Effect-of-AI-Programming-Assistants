(define (getNoZeroIntegers n)
  (for/fold ([result '()])
    ([i (in-range 1 n)])
    (if (and (not (zero? (modulo i 10))) (not (zero? (modulo (- n i) 10))))
        (begin
          (set! result (list i (- n i)))
          (values result)))))