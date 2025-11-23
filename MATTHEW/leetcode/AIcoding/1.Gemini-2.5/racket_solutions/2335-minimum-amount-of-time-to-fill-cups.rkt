(define (fill-cups cups)
  (let* ((s (apply + cups))
         (m (apply max cups)))
    (max m (quotient (+ s 1) 2))))