(define sum-region
  (lambda (matrix row1 col1 row2 col2)
    (let ((prefix-sum (vector-ref matrix 0)))
      (- (vector-ref prefix-sum (+ row2 1 col2 1))
         (vector-ref prefix-sum (+ row1 col1))
         (vector-ref prefix-sum (+ row2 1 col1))
         (vector-ref prefix-sum (+ row1 col2 1))
         ))))

(define NumMatrix
  (lambda (matrix)
    (let* ((rows (length matrix))
           (cols (if (empty? matrix) 0 (length (vector-ref matrix 0)))))
           (if (zero? rows)
               (lambda (op . args)
                 (case op
                   ((sum-region) 0)))
               (let* ((prefix-sum (make-vector (+ 1 (* rows cols)) 0))
                      (prefix-matrix (vector prefix-sum)))
                 (for ([i (in-range rows)])
                   (for ([j (in-range cols)])
                     (vector-set! prefix-sum (+ i 1 j 1)
                                  (+ (vector-ref prefix-sum (+ i j))
                                     (vector-ref prefix-sum (+ i 1 j))
                                     (vector-ref prefix-sum (+ i j 1))
                                     (- (vector-ref matrix i) j)))))

                 (lambda (op . args)
                   (case op
                     ((sum-region) (apply sum-region (cons prefix-matrix args))))))))))