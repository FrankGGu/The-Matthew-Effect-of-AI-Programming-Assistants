(define (combination-sum-iv nums target)
  (let* ([dp (make-vector (+ target 1) 0)])

    (vector-set! dp 0 1)

    (for ([i (in-range 1 (+ target 1))])
      (for ([num (in-list nums)])
        (when (>= (- i num) 0)
          (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (- i num)))))))

    (vector-ref dp target)))