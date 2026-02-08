(define (xor-segments-equal-to-zero nums)
  (define (xor-list lst)
    (foldl (lambda (x acc) (bitwise-xor x acc)) 0 lst))

  (define total-xor (xor-list nums))

  (if (zero? total-xor)
      (list 'true)
      (list 'false)))

(xor-segments-equal-to-zero '(1 2 3 4))