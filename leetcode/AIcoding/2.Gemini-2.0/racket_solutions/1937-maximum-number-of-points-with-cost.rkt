(define (max-points points)
  (let* ([m (vector-length points)]
         [n (vector-length (vector-ref points 0))])
    (define (solve row col)
      (if (= row m)
          0
          (let ([current-val (vector-ref (vector-ref points row) col)])
            (+ current-val
               (apply max (map (lambda (next-col)
                                 (- (solve (+ row 1) next-col) (abs (- col next-col))))
                               (range n)))))))
    (apply max (map (lambda (col) (solve 0 col)) (range n)))))

(define (max-points-dp points)
  (let* ([m (vector-length points)]
         [n (vector-length (vector-ref points 0))]
         [dp (make-vector n 0)])
    (for ([row (in-range m)])
      (let ([temp-dp (make-vector n 0)])
        (let loop ([col (in-range n)])
          (vector-set! temp-dp col (+ (vector-ref (vector-ref points row) col) (vector-ref dp col))))
        (let ([left (make-vector n 0)]
              [right (make-vector n 0)])
          (vector-set! left 0 (vector-ref temp-dp 0))
          (for ([i (in-range 1 n)])
            (vector-set! left i (max (- (vector-ref temp-dp i) i) (vector-ref left (- i 1)) -1)))
          (vector-set! right (- n 1) (- (vector-ref temp-dp (- n 1)) (- n 1)))
          (for ([i (in-range (- n 2) -1 -1)])
            (vector-set! right i (max (- (vector-ref temp-dp i) (- n 1 i)) (vector-ref right (+ i 1)) -1)))
          (for ([i (in-range n)])
            (vector-set! dp i (max (+ (vector-ref left i) i) (+ (vector-ref right i) (- n 1 i)))))))
    (apply max (vector->list dp))))