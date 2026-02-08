#lang racket

(define (countSubtreesWithMaxDistance n edges)
  (define graph (make-vector n '()))
  (for ([edge edges])
    (let ([u (first edge)]
          [v (second edge)])
      (vector-set! graph u (cons v (vector-ref graph u)))
      (vector-set! graph v (cons u (vector-ref graph v)))))

  (define (dfs node parent)
    (define distances (list))
    (for ([neighbor (vector-ref graph node)])
      (when (not (= neighbor parent))
        (define child-distances (dfs neighbor node))
        (set! distances (append distances (map (lambda (d) (+ d 1)) child-distances)))))
    (if (null? distances)
      (list 0)
      (cons (apply max distances) (list (length distances)))))

  (define max-distances (for/list ([i (in-range n)]) (first (dfs i -1))))
  (length (filter (lambda (x) (= x (apply max max-distances))) max-distances)))

(countSubtreesWithMaxDistance 4 '((0 1) (0 2) (1 3)))