(define (find-x-value-of-array-i nums k)
  (let* ([n (length nums)]
         [current-xor-sum (foldl bitwise-xor 0 nums)])
    (if (even? n)
        0
        (bitwise-xor current-xor-sum k))))