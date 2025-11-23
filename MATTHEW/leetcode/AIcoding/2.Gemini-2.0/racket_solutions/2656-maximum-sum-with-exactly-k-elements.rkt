(define (maximize-sum nums k)
  (let* ((max-num (apply max nums)))
    (+ (* k max-num) (/ (* k (- k 1)) 2))))