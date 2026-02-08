(define (three-divisors n)
  (if (<= n 3)
      #f
      (let ((root (integer-sqrt n)))
        (and (= (* root root) n) (prime? root)))))