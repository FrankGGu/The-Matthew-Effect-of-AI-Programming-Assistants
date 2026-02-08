(define (maximum-xor-product nums)
  (define (xor a b) (bitwise-xor a b))
  (define (product a b) (* a b))
  (define max-product (apply max 
                             (for/list ([x nums] [y nums] #:when (not (= x y)))
                               (product (xor x y) (xor y x)))))
  max-product)

(maximum-xor-product '(1 2 3 4 5))