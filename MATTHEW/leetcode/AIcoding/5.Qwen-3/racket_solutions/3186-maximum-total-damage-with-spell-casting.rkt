#lang racket

(define (maximum-total-damage- with-spell-casting power)
  (define (helper i total damage)
    (if (>= i (length power))
        total
        (let* ([current (list-ref power i)]
               [next (if (< (add1 i) (length power)) (list-ref power (add1 i)) 0)])
          (if (= current next)
              (helper (add1 i) total damage)
              (helper (add1 i) (+ total damage) 0)))))
  (helper 0 0 0))