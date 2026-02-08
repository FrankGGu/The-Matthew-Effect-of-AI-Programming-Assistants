#lang racket

(define (reachable-nodes edges restricted)
  (define restricted-set (set restricted))
  (define graph (make-hash))
  (for ([edge edges])
    (define a (car edge))
    (define b (cadr edge))
    (hash-set! graph a (cons b (hash-ref graph a '())))
    (hash-set! graph b (cons a (hash-ref graph b '()))))

  (define visited (make-hash))

  (define (dfs node)
    (if (or (hash-ref visited node #f)
            (set-member? restricted-set node))
        0
        (begin
          (hash-set! visited node #t)
          (define count 1)
          (for* ([neighbor (hash-ref graph node '())])
            (set! count (+ count (dfs neighbor)))
          )
          count)))

  (dfs 0))

(define (reachable-nodes-with-restrictions edges restricted)
  (reachable-nodes edges restricted))