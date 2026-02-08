(define (k-sum-subarray-sums nums k)
  (let* ([n (length nums)]
         [prefix-sums (make-vector (add1 n) 0)]
         [i 1])
    (for ([num (in-list nums)])
      (vector-set! prefix-sums i (+ (vector-ref prefix-sums (sub1 i)) num))
      (set! i (add1 i)))
    (let loop ([i 0]
               [result 0])
      (if (= i (- n k))
          result
          (loop (add1 i)
                (+ result
                   (vector-ref prefix-sums (+ k i 1))
                   (- (vector-ref prefix-sums i 1))))))))