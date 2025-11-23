(define (min-moves nums)
  (define n (length nums))
  (define dp (make-vector (+ n 1) (make-vector 4 0)))

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 4)])
      (vector-set! (vector-ref dp i) j
                   (+ (vector-ref (vector-ref dp (- i 1)) j)
                      (if (= (list-ref nums (- i 1)) j) 0 1))))
    (for ([j (in-range 1 4)])
      (when (> j 1)
        (vector-set! (vector-ref dp i) j
                     (min (vector-ref (vector-ref dp i) j)
                          (vector-ref (vector-ref dp i) (- j 1)))))))

  (vector-ref (vector-ref dp n) 3))