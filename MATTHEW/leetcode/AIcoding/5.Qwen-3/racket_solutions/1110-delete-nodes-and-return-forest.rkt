#lang racket

(define (delete-nodes-return-forest root to-delete)
  (define result '())
  (define (dfs node)
    (when node
      (let ([left (dfs (car node))]
            [right (dfs (cadr node))])
        (if (member (car node) to-delete)
            (begin
              (when left (set! result (cons left result)))
              (when right (set! result (cons right result)))
              #f)
            (begin
              (set-car! node left)
              (set-cdr! node right)
              #t)))))
  (when (dfs root)
    (set! result (cons root result)))
  result)