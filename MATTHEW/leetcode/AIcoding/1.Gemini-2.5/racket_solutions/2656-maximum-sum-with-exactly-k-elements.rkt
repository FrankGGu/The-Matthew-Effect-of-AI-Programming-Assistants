(define (maximumSum nums k)
  (let* ((max-val (apply max nums)))
    (/ (* k (+ (* 2 max-val) (- k 1))) 2)))