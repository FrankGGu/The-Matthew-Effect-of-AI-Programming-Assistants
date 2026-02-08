(struct num-matrix (dp))

(define (num-matrix-init matrix)
  (define m (vector-length matrix))
  (if (= m 0)
      (num-matrix (vector))
      (begin
        (define n (vector-length (vector-ref matrix 0)))
        (define dp (make-vector (+ m 1) (lambda () (make-vector (+ n 1) 0))))

        (for* ([r (in-range m)]
               [c (in-range n)])
          (vector-set! (vector-ref dp (+ r 1)) (+ c 1)
                       (+ (vector-ref (vector-ref matrix r) c)
                          (vector-ref (vector-ref dp r) (+ c 1))
                          (vector-ref (vector-ref dp (+ r 1)) c)
                          (- (vector-ref (vector-ref dp r) c)))))
        (num-matrix dp))))

(define (num-matrix-sum-region this row1 col1 row2 col2)
  (define dp (num-matrix-dp this))
  (+ (vector-ref (vector-ref dp (+ row2 1)) (+ col2 1))
     (- (vector-ref (vector-ref dp row1) (+ col2 1)))
     (- (vector-ref (vector-ref dp (+ row2 1)) col1))
     (vector-ref (vector-ref dp row1) col1)))