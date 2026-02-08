(require racket/for)

(define (solution nums max-operations)
  (define (check limit current-nums current-max-operations)
    (define total-ops
      (for/sum ([n current-nums])
        (quotient (- n 1) limit)))
    (<= total-ops current-max-operations))

  (define low 1)
  (define high (apply max nums))
  (define ans high)

  (while (<= low high)
    (define mid (+ low (quotient (- high low) 2)))
    (if (check mid nums max-operations)
        (begin
          (set! ans mid)
          (set! high (- mid 1)))
        (set! low (+ mid 1))))
  ans)