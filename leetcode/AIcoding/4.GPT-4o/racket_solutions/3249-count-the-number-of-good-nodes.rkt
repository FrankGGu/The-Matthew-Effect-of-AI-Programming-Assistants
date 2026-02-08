#lang racket

(define (goodNodes root)
  (define (helper node max-so-far)
    (when node
      (let* ((value (send node value))
             (new-max (max value max-so-far))
             (count (if (>= value max-so-far) 1 0)))
        (+ count
           (helper (send node left) new-max)
           (helper (send node right) new-max)))))
  (helper root (send root value)))