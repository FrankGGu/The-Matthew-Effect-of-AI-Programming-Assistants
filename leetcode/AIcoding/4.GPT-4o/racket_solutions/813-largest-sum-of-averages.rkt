(define (largestSumOfAverages A K)
  (define n (length A))
  (define averages (make-vector (add1 n) 0))
  (define dp (make-vector (add1 n) -inf))

  (define (compute-averages)
    (let loop ((i 0) (sum 0))
      (if (< i n)
          (begin
            (set! sum (+ sum (vector-ref A i)))
            (vector-set! averages (add1 i) (/ sum (add1 i)))
            (loop (add1 i) sum)))))

  (compute-averages)

  (define (max-average k start)
    (if (= k 1)
        (apply + (subvector A start n))
        (let loop ((i start) (best -inf))
          (if (< i n)
              (begin
                (set! best (max best (+ (vector-ref averages (add1 i)) (max-average (sub1 k) (add1 i)))))
                (loop (add1 i) best))
              best))))

  (max-average K 0))

(define (largestSumOfAverages-main)
  (define A (vector 9 1 2 3 9))
  (define K 3)
  (display (largestSumOfAverages A K)))

(largestSumOfAverages-main)