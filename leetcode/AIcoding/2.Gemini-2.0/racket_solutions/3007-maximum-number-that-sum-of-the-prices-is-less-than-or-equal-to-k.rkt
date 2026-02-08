(define (maximum-number-that-sum-of-the-prices-is-less-than-or-equal-to-k n k)
  (define (count-set-bits x)
    (if (= x 0)
        0
        (+ (remainder x 2) (count-set-bits (quotient x 2)))))

  (define (price x)
    (if (zero? x)
        0
        (if (zero? (remainder x 2))
            0
            (expt 2 (- (integer-length x) 1)))))

  (define (sum-of-prices x)
    (let loop ([i 1] [sum 0])
      (if (> i x)
          sum
          (loop (+ i 1) (+ sum (price i))))))

  (define (binary-search low high)
    (cond
      [(> low high) high]
      [else
       (let* ([mid (floor (/ (+ low high) 2))]
              [current-sum (sum-of-prices mid)])
         (cond
           [(<= current-sum k) (binary-search (+ mid 1) high)]
           [else (binary-search low (- mid 1))]))]))

  (binary-search 0 n))