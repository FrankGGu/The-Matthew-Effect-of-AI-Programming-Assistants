(define (countArrangement n k)
  (define (factorial x)
    (if (= x 0)
        1
        (* x (factorial (- x 1)))))
  (define (comb n k)
    (/ (factorial n) (* (factorial k) (factorial (- n k)))))
  (define (ways n k)
    (if (= k 0)
        1
        (+ (ways n (- k 1)) (* (comb n k) (ways (- n 1) (- k 1))))))
  (ways n k))

(define (findTheNumberOfWays n k)
  (countArrangement n k))