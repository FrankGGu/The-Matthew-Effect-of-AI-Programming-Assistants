#lang racket

(define (pathExistence queries edges)
  (define graph (make-hash))
  (for ([edge edges])
    (define a (first edge))
    (define b (second edge))
    (define a-neighbors (hash-ref graph a '()))
    (define b-neighbors (hash-ref graph b '()))
    (hash-set! graph a (cons b a-neighbors))
    (hash-set! graph b (cons a b-neighbors)))

  (define (dfs start target visited)
    (if (equal? start target) #t
        (begin
          (set! visited (cons start visited))
          (for/or ([neighbor (hash-ref graph start '())])
            (and (not (member neighbor visited))
                 (dfs neighbor target visited))))))

  (for/map ([query queries])
    (define start (first query))
    (define target (second query))
    (define visited '())
    (dfs start target visited)))

(define (pathExistenceQueries edges queries)
  (pathExistence queries edges))