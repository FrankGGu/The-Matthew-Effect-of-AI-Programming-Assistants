(define (largest-sum-of-averages nums k)
  (define n (length nums))
  (define sums (make-vector (+ n 1) 0.0))
  (for ((i (in-range 1 (+ n 1))))
    (vector-set! sums i (+ (vector-ref sums (- i 1)) (list-ref nums (- i 1)))))

  (define (dp i j)
    (cond
      [(= j 1) (/ (vector-ref sums i) i)]
      [(= i j) (vector-ref sums i)]
      [else
       (let loop ((x (- i 1)) (max-avg -inf.0))
         (if (< x j)
             max-avg
             (let ((current-avg (+ (dp x (- j 1)) (/ (- (vector-ref sums i) (vector-ref sums x)) (- i x)))))
               (loop (- x 1) (max current-avg max-avg)))))]))

  (dp n k))