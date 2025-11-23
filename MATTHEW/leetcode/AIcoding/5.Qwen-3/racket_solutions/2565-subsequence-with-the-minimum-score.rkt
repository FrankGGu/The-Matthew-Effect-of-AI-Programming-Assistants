#lang racket

(define (minimum-score s t)
  (define (helper i j)
    (cond [(= i (string-length s)) 0]
          [(= j (string-length t)) (string-length s)]
          [else
           (if (char=? (string-ref s i) (string-ref t j))
               (helper (+ i 1) (+ j 1))
               (min (+ 1 (helper (+ i 1) j)) (+ 1 (helper i (+ j 1)))))]))
  (helper 0 0))