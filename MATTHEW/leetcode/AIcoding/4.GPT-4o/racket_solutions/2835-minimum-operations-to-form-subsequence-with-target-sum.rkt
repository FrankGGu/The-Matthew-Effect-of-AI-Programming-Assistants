(define (minOperations target arr)
  (define n (length arr))
  (define dp (make-vector (+ 1 target) (lambda () +inf.0)))
  (vector-set! dp 0 0)

  (for ([num arr])
    (for ([j (range target -1 -1)])
      (when (>= j num)
        (vector-set! dp j (min (vector-ref dp j) (+ 1 (vector-ref dp (- j num))))))))

  (define result (vector-ref dp target))
  (if (= result +inf.0) -1 result))

(minOperations 9 (list 3 2 1 5 4))