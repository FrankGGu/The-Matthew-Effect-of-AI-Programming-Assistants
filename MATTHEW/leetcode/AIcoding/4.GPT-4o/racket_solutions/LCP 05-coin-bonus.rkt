(define (maxCoins piles)
  (define (helper piles)
    (let* ((n (length piles))
           (sorted-piles (sort piles >)))
      (define (take-coins k)
        (if (< k 0) 0
          (+ (list-ref sorted-piles k) (take-coins (- k 1)))))
      (define (max-take k)
        (if (>= k (/ n 3)) 0
          (+ (take-coins (- (* 2 k) 1)) (max-take (+ k 1)))))
      (max-take 0)))
  (maxCoins piles))