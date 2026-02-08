(define-struct num-matrix
  ([sum #:mutable]))

(define (make-num-matrix matrix)
  (let* ([rows (length matrix)]
         [cols (if (null? matrix) 0 (length (car matrix)))]
         [sum (build-vector (+ rows 1) (λ (_) (make-vector (+ cols 1) 0)))])
    (for ([i (in-range 1 (+ rows 1))])
      (for ([j (in-range 1 (+ cols 1))])
        (vector-set! (vector-ref sum i) j
                     (+ (vector-ref (vector-ref matrix (- i 1)) (- j 1))
                              (vector-ref (vector-ref sum (- i 1)) j)
                              (vector-ref (vector-ref sum i) (- j 1))
                              (- (vector-ref (vector-ref sum (- i 1)) (- j 1))))))
    (make-num-matrix sum)))

(define (sum-region obj row1 col1 row2 col2)
  (let ([sum (num-matrix-sum obj)])
    (+ (vector-ref (vector-ref sum (+ row2 1)) (+ col2 1))
       (- (vector-ref (vector-ref sum row1) (+ col2 1)))
       (- (vector-ref (vector-ref sum (+ row2 1)) col1))
       (vector-ref (vector-ref sum row1) col1))))