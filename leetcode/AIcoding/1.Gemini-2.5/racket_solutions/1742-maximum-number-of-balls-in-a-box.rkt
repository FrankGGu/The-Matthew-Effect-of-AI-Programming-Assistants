(define (sum-digits n)
  (let loop ((num n) (sum 0))
    (if (= num 0)
        sum
        (loop (quotient num 10) (+ sum (remainder num 10))))))

(define (maximum-number-of-balls lowLimit highLimit)
  (let ((box-counts (make-hash)))
    (for ((i (range lowLimit (+ highLimit 1))))
      (let ((digit-sum (sum-digits i)))
        (hash-set! box-counts digit-sum
                   (+ 1 (hash-ref box-counts digit-sum 0)))))
    (if (hash-empty? box-counts)
        0
        (apply max (hash-values box-counts)))))