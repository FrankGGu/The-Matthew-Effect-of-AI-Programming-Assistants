(define (number-of-ways-to-earn-points types target)
  (define MOD 1000000007)
  (define dp (make-vector (+ target 1) 0))
  (vector-set! dp 0 1)

  (for-each (lambda (type)
              (define count (car type))
              (define points (cadr type))

              (for-each (lambda (j) ; Iterate j from target down to 0
                          (for-each (lambda (k) ; Iterate k from 1 to count
                                      (when (>= j (* k points))
                                        (vector-set! dp j
                                                     (modulo (+ (vector-ref dp j)
                                                                (vector-ref dp (- j (* k points))))
                                                              MOD))))
                                    (build-list count add1)))
                        (build-list (+ target 1) (lambda (x) (- target x))))
            types)

  (vector-ref dp target))