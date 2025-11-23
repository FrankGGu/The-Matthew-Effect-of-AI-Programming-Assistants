#lang racket

(define (find-kth-character s k)
  (let loop ([s s] [k k])
    (if (<= k (string-length s))
        (string-ref s (- k 1))
        (let* ([len (string-length s)]
               [next-k (- k len)])
          (loop (string-append s (number->string (string-length s))) next-k)))))