(define (sumOfSquares nums)
  (define (is-special? x)
    (= (remainder (length nums) x) 0))
  (define (square x) (* x x))
  (apply + (map (lambda (x) (if (is-special? x) (square x) 0)) nums)))

(sumOfSquares)