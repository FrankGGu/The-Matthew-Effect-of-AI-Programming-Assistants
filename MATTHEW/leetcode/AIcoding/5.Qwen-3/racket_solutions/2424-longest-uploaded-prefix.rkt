#lang racket

(define (longest-uploaded-prefix)
  (let ([prefix 0])
    (lambda (n)
      (when (<= prefix n)
        (set! prefix (+ prefix 1)))
      prefix)))