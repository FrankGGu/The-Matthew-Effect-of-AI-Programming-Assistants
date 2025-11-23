(define (sum-digits n)
  (let loop ((num n) (sum 0))
    (if (zero? num)
        sum
        (loop (quotient num 10) (+ sum (remainder num 10))))))

(define (is-beautiful? n)
  (let ((s (sum-digits n)))
    (and (not (zero? s))
         (zero? (remainder n s)))))

(define (count-beautiful-numbers low high)
  (let loop ((i low) (count 0))
    (if (> i high)
        count
        (loop (add1 i) (if (is-beautiful? i) (add1 count) count)))))