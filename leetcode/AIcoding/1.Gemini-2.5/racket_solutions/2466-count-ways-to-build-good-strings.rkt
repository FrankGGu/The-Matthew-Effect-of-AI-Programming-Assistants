(define (count-good-strings low high zero one)
  (define MOD 1000000007)
  (define dp (make-vector (+ high 1) 0))

  (vector-set! dp 0 1)

  (for ([i (in-range 1 (+ high 1))])
    (define current-ways 0)
    (when (>= (- i zero) 0)
      (set! current-ways (modulo (+ current-ways (vector-ref dp (- i zero))) MOD)))
    (when (>= (- i one) 0)
      (set! current-ways (modulo (+ current-ways (vector-ref dp (- i one))) MOD)))
    (vector-set! dp i current-ways))

  (define total-good-strings 0)
  (for ([i (in-range low (+ high 1))])
    (set! total-good-strings (modulo (+ total-good-strings (vector-ref dp i)) MOD)))

  total-good-strings)