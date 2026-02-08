(define-struct num-matrix (prefix-sum))

(define (num-matrix-init matrix)
  (let* ([m (length matrix)]
         [n (if (zero? m) 0 (length (car matrix)))]
         [prefix-sum (make-vector (+ m 1) (lambda () (make-vector (+ n 1) 0)))])

    (for ([i (in-range 1 (+ m 1))])
      (for ([j (in-range 1 (+ n 1))])
        (vector-set! (vector-ref prefix-sum i) j
                     (+ (list-ref (list-ref matrix (- i 1)) (- j 1))
                        (vector-ref (vector-ref prefix-sum (- i 1)) j)
                        (vector-ref (vector-ref prefix-sum i) (- j 1))
                        (- (vector-ref (vector-ref prefix-sum (- i 1)) (- j 1)))))))
    (make-num-matrix prefix-sum)))

(define (num-matrix-sum-region this row1 col1 row2 col2)
  (let ([prefix-sum (num-matrix-prefix-sum this)])
    (- (+ (vector-ref (vector-ref prefix-sum (+ row2 1)) (+ col2 1))
          (vector-ref (vector-ref prefix-sum row1) col1))
       (+ (vector-ref (vector-ref prefix-sum row1) (+ col2 1))
          (vector-ref (vector-ref prefix-sum (+ row2 1)) col1)))))