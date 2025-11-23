(define (findTheWinner n x y)
  (if (or (and (= x y) (even? n))
          (and (> x y) (even? n))
          (and (< x y) (odd? n)))
      1
      2))