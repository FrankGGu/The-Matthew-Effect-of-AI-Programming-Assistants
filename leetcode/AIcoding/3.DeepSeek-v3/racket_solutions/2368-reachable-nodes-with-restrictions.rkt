#lang racket

(define (reachable-nodes n edges restricted)
  (define graph (make-hash))
  (define restricted-set (list->set restricted))
  (define visited (make-hash))

  (for ([edge edges])
    (match edge
      [(list u v)
       (hash-update! graph u (lambda (lst) (cons v lst)) '())
       (hash-update! graph v (lambda (lst) (cons u lst)) '())]))

  (define (dfs node)
    (if (or (hash-ref visited node #f) (set-member? restricted-set node))
        0
        (begin
          (hash-set! visited node #t)
          (for/sum ([neighbor (hash-ref graph node '())])
            (dfs neighbor)))))

  (add1 (dfs 0)))