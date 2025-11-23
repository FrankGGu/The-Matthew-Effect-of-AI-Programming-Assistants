#lang racket

(define (min-edges-to-make-every-node-reachable n edges)
  (define graph (make-hash))
  (for ([e edges])
    (define u (car e))
    (define v (cadr e))
    (hash-set! graph u (cons v (hash-ref graph u '())))
    (hash-set! graph v (cons u (hash-ref graph v '()))))

  (define visited (make-hash))
  (define count 0)

  (define (dfs node parent)
    (set! count (add1 count))
    (for ([neigh (hash-ref graph node)])
      (when (not (= neigh parent))
        (dfs neigh node))))

  (dfs 0 -1)

  (if (= count n)
      0
      (let ([reversals 0])
        (define (dfs2 node parent)
          (for ([neigh (hash-ref graph node)])
            (when (not (= neigh parent))
              (when (not (hash-has-key? visited (cons node neigh)))
                (hash-set! visited (cons node neigh) #t)
                (hash-set! visited (cons neigh node) #t)
                (set! reversals (add1 reversals))
                (dfs2 neigh node))))
        (dfs2 0 -1)
        reversals)))