(define MatrixSum
  (lambda (matrix)
    (define n (length matrix))
    (define m (if (zero? n) 0 (length (car matrix))))
    (define prefix-sums
      (for/list ([i n])
        (for/list ([j m])
          (if (or (zero? i) (zero? j))
              (if (zero? i) (if (zero? j) (list-ref (list-ref matrix i) j) 0) 0)
              (+ (list-ref (list-ref matrix i) j)
                 (if (zero? j) 0 (list-ref (list-ref prefix-sums (- i 1)) (- j 1)))
                 (if (zero? i) 0 (list-ref (list-ref prefix-sums (- i 1)) j))))))))

    (define (sum-region row1 col1 row2 col2)
      (- (+ (list-ref (list-ref prefix-sums row2) col2)
            (if (zero? row1) 0 (list-ref (list-ref prefix-sums (- row1 1)) col2))
            (if (zero? col1) 0 (list-ref (list-ref prefix-sums row2 (- col1 1))))
            (if (and (zero? row1) (zero? col1)) 0 (list-ref (list-ref prefix-sums (- row1 1) (- col1 1))))))
    )
    (values prefix-sums sum-region)))

(define matrix (list (list 3 0 1) (list 5 6 3) (list 7 8 9)))
(define matrix-sum (MatrixSum matrix))
(define sum-region (cdr matrix-sum))
(sum-region 0 0 2 2) ; Example usage