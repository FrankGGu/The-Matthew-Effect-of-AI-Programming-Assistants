#lang racket

(define (mirror-score s)
  (define n (string-length s))
  (define (helper i j score)
    (cond [(>= i j) score]
          [(char=? (string-ref s i) (string-ref s j)) (helper (+ i 1) (- j 1) (+ score 2))]
          [else (helper (+ i 1) (- j 1) score)]))
  (helper 0 (- n 1) 0))