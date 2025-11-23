(define (count-submatrices-with-all-ones mat)
  (define m (length mat))
  (define n (length (car mat)))

  (define heights (make-vector n 0))
  (define total-submatrices 0)

  (for ([i (in-range m)])
    (for ([j (in-range n)])
      (if (= (list-ref (list-ref mat i) j) 1)
          (vector-set! heights j (+ (vector-ref heights j) 1))
          (vector-set! heights j 0)))

    (for ([j (in-range n)])
      (define min-h (vector-ref heights j))
      (for ([k (in-range j -1 -1)])
        (set! min-h (min min-h (vector-ref heights k)))
        (set! total-submatrices (+ total-submatrices min-h)))))

  total-submatrices)