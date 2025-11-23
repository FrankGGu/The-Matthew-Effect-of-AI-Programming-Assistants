(define/contract (alternate-digit-sum n)
  (-> exact-integer? exact-integer?)
  (let loop ([num n] [sign 1] [sum 0])
    (if (zero? num)
        sum
        (let-values ([(q r) (quotient/remainder num 10)])
          (loop q (- sign) (+ sum (* sign r)))))))