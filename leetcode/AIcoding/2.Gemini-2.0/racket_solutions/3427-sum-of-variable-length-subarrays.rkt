(define (sum-of-variable-length-subarrays nums k)
  (let* ([n (length nums)]
         [sums (make-vector (add1 n) 0)])
    (for ([i (in-range n)])
      (vector-set! sums (add1 i) (+ (vector-ref sums i) (list-ref nums i))))
    (let loop ([i 0] [result 0])
      (if (= i n)
          result
          (let loop2 ([j (add1 i)])
            (if (> j n)
                (loop (add1 i) result)
                (let ([current-sum (- (vector-ref sums j) (vector-ref sums i))])
                  (loop2 (add1 j) (if (>= current-sum k) (add1 result) result)))))))))