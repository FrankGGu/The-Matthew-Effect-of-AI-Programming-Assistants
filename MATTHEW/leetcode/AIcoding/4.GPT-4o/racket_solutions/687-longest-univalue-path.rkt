#lang racket

(define (longestUnivaluePath root)
  (define max-length (list 0))

  (define (helper node parent-value)
    (if (null? node)
        0
        (let* ((val (send node value))
               (left-length (helper (send node left) val))
               (right-length (helper (send node right) val))
               (current-length (+ left-length right-length)))
          (when (equal? val parent-value)
            (set! current-length (+ current-length 1)))
          (set! max-length (max (car max-length) current-length))
          (if (equal? val parent-value)
              (+ 1 (max left-length right-length))
              0))))

  (helper root #f)
  (car max-length))