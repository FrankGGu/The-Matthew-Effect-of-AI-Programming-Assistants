#lang racket

(define (find-keystrokes s)
  (define (helper i res)
    (if (>= i (string-length s))
        (list->string (reverse res))
        (let ((c (string-ref s i)))
          (if (char=? c #\#)
              (helper (+ i 1) (if (null? res) res (cdr res)))
              (helper (+ i 1) (cons c res))))))
  (helper 0 '()))