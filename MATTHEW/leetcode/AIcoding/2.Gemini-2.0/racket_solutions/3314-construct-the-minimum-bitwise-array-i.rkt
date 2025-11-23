(define (constructBitwiseArray n)
  (cond [(even? n) (append (for/list ([i (in-range 1 (+ n 1) 2)]) i)
                            (for/list ([i (in-range 2 (+ n 1) 2)]) i))]
        [else (append (for/list ([i (in-range 1 n 2)]) i)
                      (for/list ([i (in-range 2 n 2)]) i)
                      (list n))]))