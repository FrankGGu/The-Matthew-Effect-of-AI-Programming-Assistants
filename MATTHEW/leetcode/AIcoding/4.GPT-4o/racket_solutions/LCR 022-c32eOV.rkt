#lang racket

(define (detectCycle head)
  (define (helper slow fast)
    (if (or (null? fast) (null? (cdr fast)))
        #f
        (if (equal? slow fast)
            (let loop ((ptr head))
              (if (equal? ptr slow)
                  ptr
                  (loop (cdr ptr))))
            (helper (cdr slow) (cdr (cdr fast))))))
  (helper head head))