(define/contract (reverse x)
  (-> exact-integer? exact-integer?)
  (define (helper n acc)
    (if (= n 0)
        acc
        (helper (quotient n 10) (+ (* acc 10) (remainder n 10)))))
  (define rev (helper (abs x) 0))
  (if (< x 0) (set! rev (- rev)))
  (if (or (< rev (- (expt 2 31))) (> rev (- (expt 2 31) 1)))
      0
      rev))