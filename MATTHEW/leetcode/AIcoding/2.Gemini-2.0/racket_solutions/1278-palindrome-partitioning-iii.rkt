(define (palindromePartitioningIII s k)
  (define n (string-length s))
  (define (cost i j)
    (let loop ((l i) (r j) (count 0))
      (if (> l r)
          count
          (if (char=? (string-ref s l) (string-ref s r))
              (loop (+ l 1) (- r 1) count)
              (loop (+ l 1) (- r 1) (+ count 1))))))

  (define dp (make-vector (+ k 1) (make-vector (+ n 1) #f)))

  (for ((i (in-range 0 (+ n 1))))
    (vector-set! (vector-ref dp 0) i 0))

  (for ((i (in-range 1 (+ k 1))))
    (for ((j (in-range 1 (+ n 1))))
      (let loop ((l 1) (min-cost +inf.0))
        (if (> l j)
            (vector-set! (vector-ref dp i) j min-cost)
            (let ((current-cost (+ (vector-ref (vector-ref dp (- i 1)) (- l 1)) (cost (- l 1) (- j 1)))))
              (loop (+ l 1) (min min-cost current-cost)))))))

  (vector-ref (vector-ref dp k) n))