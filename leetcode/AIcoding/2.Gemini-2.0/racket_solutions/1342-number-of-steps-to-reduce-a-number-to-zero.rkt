(define (number-of-steps num)
  (cond ((zero? num) 0)
        ((even? num) (+ 1 (number-of-steps (/ num 2))))
        (else (+ 1 (number-of-steps (- num 1))))))