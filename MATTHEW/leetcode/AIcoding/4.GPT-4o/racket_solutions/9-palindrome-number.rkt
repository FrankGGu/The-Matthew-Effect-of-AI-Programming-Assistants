(define (is-palindrome n)
  (define (reverse num)
    (let loop ((x num) (reversed 0))
      (if (= x 0)
          reversed
          (loop (quotient x 10) (+ (* reversed 10) (remainder x 10))))))
  (define (is-negative? x) (< x 0))
  (define (equal? x y) (equal? x y))
  (if (is-negative? n)
      #f
      (equal? n (reverse n))))