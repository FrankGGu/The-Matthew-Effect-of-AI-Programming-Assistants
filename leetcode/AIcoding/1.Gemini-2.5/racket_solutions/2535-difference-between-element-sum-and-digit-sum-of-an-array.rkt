(define (solution nums)
  (define (sum-digits n)
    (if (= n 0)
        0
        (+ (modulo n 10) (sum-digits (quotient n 10)))))

  (let* ((element-sum (apply + nums))
         (digit-sum (apply + (map sum-digits nums))))
    (abs (- element-sum digit-sum))))