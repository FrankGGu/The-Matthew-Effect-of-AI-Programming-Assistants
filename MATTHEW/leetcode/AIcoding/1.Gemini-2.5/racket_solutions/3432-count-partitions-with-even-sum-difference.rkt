(define (count-partitions-with-even-sum-difference nums)
  (let* ((n (length nums))
         (total-sum (foldl + 0 nums))
         (modulus 1000000007))
    (if (odd? total-sum)
        0
        (let loop ((base 2) (exp n) (res 1))
          (if (= exp 0)
              res
              (loop (remainder (* base base) modulus)
                    (quotient exp 2)
                    (if (odd? exp)
                        (remainder (* res base) modulus)
                        res)))))))