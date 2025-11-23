(define (soup-servings n)
  (if (>= n 4800) 1.0
      (let ([m (ceiling (/ n 25))])
        (let ([memo (make-hash)])
          (define (dp a b)
            (cond
              [(<= a 0) (if (<= b 0) 0.5 1.0)]
              [(<= b 0) 0.0]
              [(hash-has-key? memo (cons a b)) (hash-ref memo (cons a b))]
              [else
               (let ([res (* 0.25 (+ (dp (- a 4) b)
                                      (dp (- a 3) (- b 1))
                                      (dp (- a 2) (- b 2))
                                      (dp (- a 1) (- b 3))))])
                 (hash-set! memo (cons a b) res)
                 res)]))
          (dp m m)))))