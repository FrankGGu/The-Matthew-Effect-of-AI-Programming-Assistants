#lang racket

(define (vertical-order-traversal root)
  (define (dfs node col row map)
    (if (not node)
        map
        (let* ([val (node-val node)]
               [current (hash-ref map col '())]
               [new-entry (cons (cons row val) current)]
               [new-map (hash-set map col new-entry)])
          (dfs (node-left node) (sub1 col) (add1 row) new-map)
          (dfs (node-right node) (add1 col) (add1 row) new-map))))

  (define (sort-entries entries)
    (sort entries (lambda (a b) (< (car a) (car b)))))

  (define (process-map map)
    (define cols (sort (hash-keys map) <))
    (map (lambda (col)
           (map cdr (sort-entries (hash-ref map col))))
         cols))

  (if (not root)
      '()
      (process-map (dfs root 0 0 (hash)))))

(define (node-val node) (car node))
(define (node-left node) (cadr node))
(define (node-right node) (caddr node))