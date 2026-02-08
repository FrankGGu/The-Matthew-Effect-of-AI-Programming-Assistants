(define (count-digit-one n)
  (if (< n 1)
      0
      (let loop ((k 1) (total-ones 0))
        (if (> k n)
            total-ones
            (let* ((divisor (* k 10))
                   (quotient (floor (/ n divisor)))
                   (remainder (modulo n divisor)))
              (let ((current-ones (+ (* quotient k)
                                     (if (>= remainder k)
                                         (min (- remainder k -1) k)
                                         0))))
                (loop (* k 10) (+ total-ones current-ones))))))))