(define (maximum-amount-of-money-robot-can-earn grid)
  (let* ((m (length grid))
         (n (length (car grid)))
         (dp (make-vector m (lambda () (make-vector n 0)))))

    ;; Initialize dp[0][0]
    (vector-set! (vector-ref dp 0) 0 (list-ref (list-ref grid 0) 0))

    ;; Initialize first row
    (for ((j (in-range 1 n)))
      (vector-set! (vector-ref dp 0) j
                   (+ (list-ref (list-ref grid 0) j)
                      (vector-ref (vector-ref dp 0) (- j 1)))))

    ;; Initialize first column
    (for ((i (in-range 1 m)))
      (vector-set! (vector-ref dp i) 0
                   (+ (list-ref (list-ref grid i) 0)
                      (vector-ref (vector-ref dp (- i 1)) 0))))

    ;; Fill the rest of the dp table
    (for* ((i (in-range 1 m))
           (j (in-range 1 n)))
      (vector-set! (vector-ref dp i) j
                   (+ (list-ref (list-ref grid i) j)
                      (max (vector-ref (vector-ref dp (- i 1)) j)
                           (vector-ref (vector-ref dp i) (- j 1))))))

    ;; The result is at dp[m-1][n-1]
    (vector-ref (vector-ref dp (- m 1)) (- n 1))))