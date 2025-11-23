#lang racket

(define (maxWeightSum n edges)
  (define graph (make-vector n '()))
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (define w (caddr edge))
    (vector-set! graph u (cons (list v w) (vector-ref graph u)))
    (vector-set! graph v (cons (list u w) (vector-ref graph v))))

  (define (dfs node parent)
    (define total 0)
    (define max1 0)
    (define max2 0)
    (for ([neighbor (vector-ref graph node)])
      (define next-node (car neighbor))
      (define weight (cadr neighbor))
      (if (not (= next-node parent))
          (begin
            (define res (dfs next-node node))
            (set! total (+ total res))
            (if (> res weight)
                (begin
                  (set! max2 max1)
                  (set! max1 res))
                (set! max2 (max max2 res))))))
    (set! total (+ total max1 max2))
    total)

  (define (findMaxWeight)
    (define max-sum 0)
    (for ([i (in-range n)])
      (define current-sum (dfs i -1))
      (set! max-sum (max max-sum current-sum)))
    max-sum)

  (findMaxWeight))

(define n 5)
(define edges '((0 1 1) (1 2 2) (2 3 3) (3 4 4)))
(maxWeightSum n edges)