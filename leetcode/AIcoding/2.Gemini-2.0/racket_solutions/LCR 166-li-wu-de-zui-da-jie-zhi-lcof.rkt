(define (maxValue grid)
  (define rows (length grid))
  (define cols (length (first grid)))

  (define dp (make-vector (+ rows 1) (make-vector (+ cols 1) 0)))

  (for ([i (in-range 1 (+ rows 1))])
    (for ([j (in-range 1 (+ cols 1))])
      (vector-set! (vector-ref dp i) j
                   (+ (list-ref (list-ref grid (- i 1)) (- j 1))
                      (max (vector-ref (vector-ref dp (- i 1)) j)
                           (vector-ref (vector-ref dp i) (- j 1)))))))

  (vector-ref (vector-ref dp rows) cols))