(define/contract (make-integer-beautiful n target)
  (-> exact-integer? exact-integer? exact-integer?)
  (define (sum-digits x)
    (let loop ([x x] [sum 0])
      (if (zero? x)
          sum
          (let-values ([(q r) (quotient/remainder x 10)])
            (loop q (+ sum r))))))

  (let loop ([n n] [add 0] [base 1])
    (if (<= (sum-digits n) target)
        add
        (let-values ([(q r) (quotient/remainder n 10)])
          (loop (quotient (+ n 1) 10)
                (+ add (* (- 10 r) base))
                (* base 10))))))