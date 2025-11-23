(define (count-largest-group n)
  (define (digit-sum num)
    (let loop ((n num) (sum 0))
      (if (= n 0)
          sum
          (loop (quotient n 10) (+ sum (remainder n 10))))))

  (define counts (make-hash))

  (for ([i (in-range 1 (add1 n))])
    (define ds (digit-sum i))
    (hash-set! counts ds (add1 (hash-ref counts ds 0))))

  (define max-freq 0)
  (for ([val (in-list (hash-values counts))])
    (set! max-freq (max max-freq val)))

  (define result 0)
  (for ([val (in-list (hash-values counts))])
    (when (= val max-freq)
      (set! result (add1 result))))
  result)