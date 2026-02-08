#lang racket

(define (min-steps n)
  (cond
    ((= n 1) 0)
    (else
     (let loop ((current-n n) (divisor 2) (total-steps 0))
       (cond
         ((> current-n 1)
          (cond
            ((= (remainder current-n divisor) 0)
             (loop (quotient current-n divisor) divisor (+ total-steps divisor)))
            ((> (* divisor divisor) current-n)
             (+ total-steps current-n))
            (else
             (loop current-n (+ divisor 1) total-steps))))
         (else
          total-steps))))))