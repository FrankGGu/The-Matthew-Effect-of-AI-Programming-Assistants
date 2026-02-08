#lang racket

(define (count-highest-score-nodes parents)
  (define n (length parents))
  (define children (make-vector n '()))
  (for ([i (in-range 1 n)])
    (define p (list-ref parents i))
    (vector-set! children p (cons i (vector-ref children p))))

  (define max-score 0)
  (define count 0)

  (define (dfs node)
    (define lst (vector-ref children node))
    (define total 1)
    (define product 1)
    (for ([child lst])
      (define cnt (dfs child))
      (set! product (* product cnt))
      (set! total (+ total cnt)))
    (define score (* product (if (= node 0) 1 (- n total))))
    (cond
      [(> score max-score) (set! max-score score) (set! count 1)]
      [(= score max-score) (set! count (add1 count))])
    total)

  (dfs 0)
  count)