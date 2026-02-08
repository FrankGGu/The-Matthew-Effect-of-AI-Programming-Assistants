(define (count-balls low high)
  (define (digit-sum n)
    (let loop ([n n] [sum 0])
      (if (zero? n)
          sum
          (loop (quotient n 10) (+ sum (remainder n 10))))))

  (let ([counts (make-hash)])
    (for ([i (in-range low (+ high 1))])
      (let ([sum (digit-sum i)])
        (hash-update! counts sum add1 0)))
    (apply max (hash-values counts))))