(define (sum-digits num)
  (let loop ((n num) (sum 0))
    (if (= n 0)
        sum
        (loop (quotient n 10) (+ sum (modulo n 10))))))

(define (is-harshad x)
  (let ((s (sum-digits x)))
    (= (modulo x s) 0)))