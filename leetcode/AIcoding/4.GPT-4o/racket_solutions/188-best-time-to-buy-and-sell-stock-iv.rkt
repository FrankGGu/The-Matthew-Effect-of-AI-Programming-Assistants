(define (maxProfit k prices)
  (define n (length prices))
  (if (or (= k 0) (= n 0)) 0
      (let ((k (min k (/ n 2))))
        (define dp (make-vector (+ 1 k) (make-vector (+ 1 n) 0)))
        (for ([i (in-range 1 (+ 1 k))])
          (for ([j (in-range 1 (+ 1 n))])
            (let* ((max-so-far 0))
              (for ([m (in-range 1 j)])
                (set! max-so-far (max max-so-far (- (vector-ref dp (- i 1) m) (vector-ref prices (- j 1))))))
              (vector-set! dp i j (max (vector-ref dp i j) (+ (vector-ref dp (- i 1) j) (vector-ref prices (- j 1))) max-so-far))))))
        (vector-ref dp k n))))

(maxProfit 2 (list 2 4 1)) ; Example input for testing