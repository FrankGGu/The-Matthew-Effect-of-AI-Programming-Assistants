#lang racket

(define (height root)
  (if (not root)
      0
      (let ((left (height (car root)))
            (right (height (cadr root))))
        (if (or (= left -1) (= right -1) (> (abs (- left right)) 1))
            -1
            (+ 1 (max left right))))))

(define (is-balanced root)
  (> (height root) -1))