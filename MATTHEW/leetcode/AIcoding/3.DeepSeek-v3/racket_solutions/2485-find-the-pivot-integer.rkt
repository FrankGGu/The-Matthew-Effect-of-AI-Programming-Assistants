(define/contract (pivot-integer n)
  (-> exact-integer? exact-integer?)
  (let loop ((i 1))
    (if (> i n)
        -1
        (let ((sum1 (quotient (* i (add1 i)) 2))
              (sum2 (quotient (* (+ i n) (- (add1 n) i)) 2)))
          (if (= sum1 sum2)
              i
              (loop (add1 i)))))))