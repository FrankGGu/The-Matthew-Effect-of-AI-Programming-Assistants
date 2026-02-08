(define (modifyMatrix matrix)
  (define rows (length matrix))
  (define cols (length (first matrix)))
  (define zero-rows (make-vector rows #f))
  (define zero-cols (make-vector cols #f))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (= (matrix-ref matrix i j) 0)
        (vector-set! zero-rows i #t)
        (vector-set! zero-cols j #t)))))

  (for ([i (in-range rows)])
    (for ([j (in-range cols)])
      (when (or (vector-ref zero-rows i) (vector-ref zero-cols j))
        (matrix-set! matrix i j 0))))

  matrix)