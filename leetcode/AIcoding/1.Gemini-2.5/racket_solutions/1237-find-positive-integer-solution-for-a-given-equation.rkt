#lang racket

(define (find-positive-integer-solution customFunction z)
  (let loop ((x 1)
             (y 1000)
             (result '()))
    (cond
      ((or (> x 1000) (< y 1))
       (reverse result))
      (else
       (let ((val (customFunction x y)))
         (cond
           ((= val z)
            (loop (+ x 1) (- y 1) (cons (list x y) result)))
           ((< val z)
            (loop (+ x 1) y result))
           (else
            (loop x (- y 1) result))))))))