(define (maximum-count nums)
  (let-values (((pos-count neg-count)
                (for/fold ((pos 0) (neg 0))
                          ((n nums))
                  (cond
                    ((> n 0) (values (+ pos 1) neg))
                    ((< n 0) (values pos (+ neg 1)))
                    (else (values pos neg))))))
    (max pos-count neg-count)))