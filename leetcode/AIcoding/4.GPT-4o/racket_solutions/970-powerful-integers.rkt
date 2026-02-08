(define (powerful-integers x y bound)
  (define powerful-integers-set (make-hash))
  (for* ([i (in-range 0 (add1 (floor (log bound x))) 1)]
         [j (in-range 0 (add1 (floor (log bound y))) 1)])
    (let ([value (+ (expt x i) (expt y j))])
      (when (<= value bound)
        (hash-set! powerful-integers-set value #t))))
  (hash-keys powerful-integers-set))