(define (kth-grammar n k)
  (if (= n 1)
      0
      (let ((parent (kth-grammar (- n 1) (quotient (+ k 1) 2))))
        (if (zero? (remainder k 2))
            (if (zero? parent) 1 0)
            parent))))