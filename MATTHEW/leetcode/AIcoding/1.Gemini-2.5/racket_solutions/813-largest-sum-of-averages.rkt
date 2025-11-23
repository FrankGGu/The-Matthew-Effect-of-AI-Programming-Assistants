(define (largest-sum-of-averages nums k)
  (define n (length nums))

  (define prefix-sums
    (let loop ((lst nums) (current-sum 0) (acc '(0)))
      (if (empty? lst)
          (reverse acc)
          (let ((new-sum (+ current-sum (car lst))))
            (loop (cdr lst) new-sum (cons new-sum acc))))))

  (define dp (make-vector (+ n 1) #f))

  (for ((i (in-range (+ n 1))))
    (vector-set! dp i (make-vector (+ k 1) 0.0)))

  (for ((i (in-range 1 (+ n 1))))
    (let ((sum-i (vector-ref prefix-sums i)))
      (vector-set! (vector-ref dp i) 1 (/ (exact->inexact sum-i) i))))

  (for ((j (in-range 2 (+ k 1))))
    (for ((i (in-range 1 (+ n 1))))
      (when (>= i j)
        (let ((max-avg 0.0))
          (for ((p (in-range (sub1 j) i)))
            (let* ((prev-dp-val (vector-ref (vector-ref dp p) (sub1 j)))
                   (sum-p-to-i (- (vector-ref prefix-sums i) (vector-ref prefix-sums p)))
                   (count-p-to-i (- i p))
                   (current-avg (+ prev-dp-val (/ (exact->inexact sum-p-to-i) count-p-to-i))))
              (when (> current-avg max-avg)
                (set! max-avg current-avg))))
          (vector-set! (vector-ref dp i) j max-avg)))))

  (vector-ref (vector-ref dp n) k))