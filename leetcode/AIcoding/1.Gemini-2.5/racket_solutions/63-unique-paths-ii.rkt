(define (unique-paths-with-obstacles obstacleGrid)
  (let* ((m (vector-length obstacleGrid))
         (n (vector-length (vector-ref obstacleGrid 0)))
         (dp (make-vector m (lambda () (make-vector n 0)))))

    (if (= (vector-ref (vector-ref obstacleGrid 0) 0) 1)
        (vector-set! (vector-ref dp 0) 0 0)
        (vector-set! (vector-ref dp 0) 0 1))

    (for ((j (in-range 1 n)))
      (if (= (vector-ref (vector-ref obstacleGrid 0) j) 1)
          (vector-set! (vector-ref dp 0) j 0)
          (vector-set! (vector-ref dp 0) j (vector-ref (vector-ref dp 0) (- j 1)))))

    (for ((i (in-range 1 m)))
      (if (= (vector-ref (vector-ref obstacleGrid i) 0) 1)
          (vector-set! (vector-ref dp i) 0 0)
          (vector-set! (vector-ref dp i) 0 (vector-ref (vector-ref dp (- i 1)) 0))))

    (for ((i (in-range 1 m)))
      (for ((j (in-range 1 n)))
        (if (= (vector-ref (vector-ref obstacleGrid i) j) 1)
            (vector-set! (vector-ref dp i) j 0)
            (vector-set! (vector-ref dp i) j
                         (+ (vector-ref (vector-ref dp (- i 1)) j)
                            (vector-ref (vector-ref dp i) (- j 1)))))))

    (vector-ref (vector-ref dp (- m 1)) (- n 1))))