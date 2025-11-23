(define (double-modular-exponentiation a b c d e)
  (let loop ([i 0]
             [result 1])
    (if (= i d)
        result
        (loop (+ i 1)
              (modulo (expt (modulo (+ a i) e) b) c)))))