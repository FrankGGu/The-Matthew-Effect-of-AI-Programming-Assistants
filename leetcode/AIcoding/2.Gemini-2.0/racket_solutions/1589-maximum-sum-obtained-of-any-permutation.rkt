(define (max-sum-range-query nums requests)
  (define n (length nums))
  (define diff-arr (make-vector (add1 n) 0))

  (for ([req requests])
    (let ([start (list-ref req 0)]
          [end (list-ref req 1)])
      (vector-set! diff-arr start (+ (vector-ref diff-arr start) 1))
      (when (< (add1 end) n)
        (vector-set! diff-arr (add1 end) (- (vector-ref diff-arr (add1 end)) 1)))))

  (define freq-arr (make-vector n 0))
  (vector-set! freq-arr 0 (vector-ref diff-arr 0))
  (for ([i (range 1 n)])
    (vector-set! freq-arr i (+ (vector-ref freq-arr (sub1 i)) (vector-ref diff-arr i))))

  (define sorted-nums (sort nums >))
  (define sorted-freq (sort (vector->list freq-arr) >))

  (define (calculate-max-sum)
    (let loop ([i 0] [sum 0])
      (if (= i n)
          sum
          (loop (add1 i) (modulo (+ sum (* (list-ref sorted-nums i) (list-ref sorted-freq i))) 1000000007)))))

  (calculate-max-sum))