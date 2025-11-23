#lang racket

(define (find-duplicate-subtrees root)
  (define (serialize node)
    (if (not node)
        "null"
        (string-append (symbol->string (car node)) "," (serialize (cadr node)) "," (serialize (caddr node)))))

  (define (helper node)
    (if (not node)
        '()
        (let* ([s (serialize node)]
               [left (helper (cadr node))]
               [right (helper (caddr node))]
               [count (hash-ref count-hash 0)])
          (hash-set! count-hash s (+ count 1))
          (if (= (hash-ref count-hash s) 2)
              (cons node (append left right))
              (append left right)))))

  (define count-hash (make-hash))
  (helper root))