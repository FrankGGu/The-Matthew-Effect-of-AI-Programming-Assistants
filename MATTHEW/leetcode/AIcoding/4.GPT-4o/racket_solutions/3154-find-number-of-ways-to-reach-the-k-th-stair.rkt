(define (countWays n k)
  (define (helper n k)
    (if (or (= k 0) (= k 1)) 1
        (+ (helper n (- k 1)) (helper n (- k n)))))
  (helper n k))

(define (numWays n k)
  (countWays n k))