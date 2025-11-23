(define (matrix-block-sum mat k)
  (let* ([m (length mat)]
         [n (length (first mat))]
         [prefix-sum (make-matrix (+ m 1) (+ n 1) 0)])
    (for* ([i (in-range 0 m)]
           [j (in-range 0 n)])
      (matrix-set! prefix-sum (+ i 1) (+ j 1)
                   (+ (matrix-ref mat i j)
                      (matrix-ref prefix-sum i (+ j 1))
                      (matrix-ref prefix-sum (+ i 1) j)
                      (- (matrix-ref prefix-sum i j)))))
    (define result (make-matrix m n 0))
    (for* ([i (in-range 0 m)]
           [j (in-range 0 n)])
      (let* ([r1 (max 0 (- i k))]
             [c1 (max 0 (- j k))]
             [r2 (min m (+ i k))]
             [c2 (min n (+ j k))])
        (matrix-set! result i j
                     (- (+ (matrix-ref prefix-sum (+ r2 1) (+ c2 1))
                           (matrix-ref prefix-sum r1 c1))
                        (+ (matrix-ref prefix-sum (+ r2 1) c1)
                           (matrix-ref prefix-sum r1 (+ c2 1))))))
    result))

(define (make-matrix rows cols initial-value)
  (let ([matrix (make-vector rows (make-vector cols initial-value))])
    (for ([i (in-range rows)])
      (vector-set! matrix i (make-vector cols initial-value)))
    matrix))

(define (matrix-ref matrix row col)
  (vector-ref (vector-ref matrix row) col))

(define (matrix-set! matrix row col value)
  (vector-set! (vector-ref matrix row) col value))