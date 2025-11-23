#lang racket

(define (solve-questions-with-brainpower questions)
  (define (helper i)
    (if (>= i (length questions))
        0
        (let* ([q (list-ref questions i)]
               [points (car q)]
               [brainpower (cadr q)]
               [next-i (+ i brainpower 1)])
          (max (+ points (helper next-i)) (helper (+ i 1))))))
  (helper 0))