(define (countSubsets nums limit)
  (define n (length nums))
  (define dp (make-vector (+ limit 1) 0))
  (vector-set! dp 0 1)

  (for ([num nums])
    (for ([j (range limit -1 -1)]) 
      (when (>= j num)
        (vector-set! dp j (+ (vector-ref dp j) (vector-ref dp (- j num))))))
    )
  (apply + (vector->list (vector-slice dp 0 (+ limit 1)))))

(define (countSubsetsWithBoundedSum nums limit)
  (countSubsets nums limit))