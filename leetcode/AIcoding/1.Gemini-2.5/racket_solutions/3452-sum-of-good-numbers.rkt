(define (sum-of-good-numbers nums)
  (define (sum-digits num)
    (if (zero? num)
        0
        (+ (remainder num 10) (sum-digits (quotient num 10)))))

  (apply +
         (filter (lambda (num)
                   (zero? (remainder (sum-digits num) 3)))
                 nums)))