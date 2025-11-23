(define (count-digit-one n)
  (define (count-ones n p)
    (if (zero? n)
        0
        (let* ([high (quotient n p)]
               [rem (remainder n p)]
               [next-p (* p 10)])
          (cond
            [(= high 0) rem]
            [(= high 1) (+ rem 1 p)]
            [else (+ p next-p)]))))

  (if (<= n 0)
      0
      (let loop ([i 1]
                 [count 0])
        (if (> i n)
            count
            (loop (* i 10) (+ count (count-ones n i)))))))