(define/public (countBits n)
  (define results (make-vector (+ n 1) 0))

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! results i
                 (+ (vector-ref results (arithmetic-shift i -1))
                    (bitwise-and i 1))))

  (vector->list results))