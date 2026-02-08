#lang racket

(define (countUnreachablePairs n edges)
  (define graph (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! graph v (cons u (vector-ref graph v)))))

  (define (dfs node visited)
    (set! visited (cons node visited))
    (for ([neighbor (vector-ref graph node)])
      (unless (member neighbor visited)
        (dfs neighbor visited)))
    (length visited))

  (define visited '())
  (define component-sizes '())

  (for ([i (in-range n)])
    (unless (member i visited)
      (let ([size (dfs i visited)])
        (set! component-sizes (cons size component-sizes)))))

  (define total-pairs (/ (* n (- n 1)) 2))
  (define reachable-pairs (apply + (map (lambda (x) (/ (* x (- x 1)) 2)) component-sizes)))

  (- total-pairs reachable-pairs))

(define (countUnreachablePairs n edges)
  (countUnreachablePairs n edges))