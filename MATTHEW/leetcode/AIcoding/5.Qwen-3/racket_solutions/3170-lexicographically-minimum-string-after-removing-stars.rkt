#lang racket

(define (remove-stars s)
  (define (loop i stack)
    (cond [(= i (string-length s)) (list->string (reverse stack))]
          [(char=? #\* (string-ref s i))
           (loop (+ i 1) (cdr stack))]
          [else
           (loop (+ i 1) (cons (string-ref s i) stack))]))
  (loop 0 '()))

(define/contract (lexicographically-minimum-string-after-removing-stars s)
  (-> string? string?)
  (remove-stars s))