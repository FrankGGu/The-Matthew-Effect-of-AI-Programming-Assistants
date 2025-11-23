(define (minimum-addition n k)
  (define (sum-digits n)
    (if (= n 0)
        0
        (+ (remainder n 10) (sum-digits (quotient n 10)))))

  (define (next-beautiful n k)
    (let loop ((n n) (power 1))
      (if (>= (sum-digits n) k)
          n
          (let ((remainder (remainder n 10)))
            (if (= remainder 0)
                (loop (quotient n 10) (* power 10))
                (let ((add (- 10 remainder)))
                  (loop (+ (quotient n 10) 1) (* power 10))
                  (+ n add (* power 1))))))))

  (- (next-beautiful n k) n))