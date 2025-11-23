#lang racket

(define (double-nodes head)
  (define (add-carries node)
    (if (not node)
        0
        (let* ([carry (add-carries (cdr node))]
               [val (+ (* (car node) 2) carry)]
               [new-val (modulo val 10)]
               [new-carry (quotient val 10)])
          (set-car! node new-val)
          new-carry)))

  (define (prepend-node head val)
    (if (null? head)
        (list val)
        (cons val head)))

  (let ([carry (add-carries head)])
    (if (> carry 0)
        (prepend-node head carry)
        head)))

(define (double-linked-list head)
  (double-nodes head))