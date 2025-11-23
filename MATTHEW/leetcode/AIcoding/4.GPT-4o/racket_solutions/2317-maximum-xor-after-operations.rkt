(define (maximumXOR nums)
  (define (xor a b) (bitwise-xor a b))
  (define (max-xor num)
    (if (null? num) 0
        (max (max-xor (cdr num)) (foldl xor 0 (cdr num)))))
  (max-xor nums))

(maximumXOR (list 1 2 3 4))