(define (sum-base n k)
  (let loop ([n n] [sum 0])
    (if (zero? n)
        sum
        (let-values ([(q r) (quotient/remainder n k)])
          (loop q (+ sum r))))))