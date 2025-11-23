(define/contract (find-maximum-number k x)
  (-> exact-integer? exact-integer? exact-integer?)
  (define (count-set-bits n)
    (let loop ([n n] [count 0])
      (if (zero? n)
          count
          (loop (arithmetic-shift n -1) (+ count (bitwise-and n 1))))))

  (define (sum-prices n)
    (let loop ([i 1] [sum 0])
      (if (> i n)
          sum
          (loop (+ i 1) (+ sum (if (zero? (remainder i x))
                                   (count-set-bits i)
                                   0))))))

  (let binary-search ([low 1] [high (expt 2 60)])
    (if (> low high)
        high
        (let* ([mid (quotient (+ low high) 2)]
               [sum (sum-prices mid)])
          (cond
            [(<= sum k) (binary-search (+ mid 1) high)]
            [else (binary-search low (- mid 1))])))))