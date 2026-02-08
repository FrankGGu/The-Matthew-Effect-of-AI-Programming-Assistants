(define-struct num-matrix
  ([sum #:mutable]))

(define (num-matrix-init matrix)
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))]
         [dp (build-list (add1 rows) (λ (x) (make-list (add1 cols) 0)))])
    (for ([i (in-range 1 (add1 rows))])
      (for ([j (in-range 1 (add1 cols))])
        (list-set! (list-ref dp i) j
                   (+ (list-ref (list-ref matrix (sub1 i)) (sub1 j))
                      (list-ref (list-ref dp (sub1 i)) j)
                      (list-ref (list-ref dp i) (sub1 j))
                      (- (list-ref (list-ref dp (sub1 i)) (sub1 j)))))))
    (make-num-matrix dp)))

(define (sum-region nm row1 col1 row2 col2)
  (let ([dp (num-matrix-sum nm)])
    (+ (list-ref (list-ref dp (add1 row2)) (add1 col2))
       (- (list-ref (list-ref dp row1) (add1 col2)))
       (- (list-ref (list-ref dp (add1 row2)) col1))
       (list-ref (list-ref dp row1) col1))))