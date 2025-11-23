#lang racket

(define (find-substring s a b)
  (define len (string-length s))
  (define (equal? i j)
    (and (<= i len) (<= j len) (equal? (substring s i (+ i (string-length a))) a)))
  (define (loop i)
    (cond [(>= i (- len (string-length a))) #f]
          [(equal? i a) i]
          [else (loop (+ i 1))]))
  (loop 0))