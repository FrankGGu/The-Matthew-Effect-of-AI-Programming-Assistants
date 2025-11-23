#lang racket

(define (minimum-suffix-flips b)
  (define (flip c)
    (if (char=? c #\0) #\1 #\0))
  (define (loop s res)
    (if (null? s)
        res
        (let ((c (car s)))
          (if (and (not (null? (cdr s))) (char=? c (cadr s)))
              (loop (cdr s) res)
              (loop (cdr s) (+ res 1))))))
  (loop (string->list b) 0))