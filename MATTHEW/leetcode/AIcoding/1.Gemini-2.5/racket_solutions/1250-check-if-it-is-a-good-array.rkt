(define (is-good-array nums)
  (= 1 (foldl gcd (car nums) (cdr nums))))