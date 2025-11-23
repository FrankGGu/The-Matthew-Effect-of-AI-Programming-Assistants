#lang racket

(define (sum-of-distances-in-tree n edges)
  (define adj (make-vector n '()))
  (for ([edge edges])
    (let ([u (car edge)]
          [v (cadr edge)])
      (vector-set! adj u (cons v (vector-ref adj u)))
      (vector-set! adj v (cons u (vector-ref adj v)))))

  (define count (make-vector n 1))
  (define res (make-vector n 0))

  (define (dfs node parent)
    (for ([child (vector-ref adj node)])
      (when (not (equal? child parent))
        (dfs child node)
        (vector-set! count node (+ (vector-ref count node) (vector-ref count child)))
        (vector-set! res node (+ (vector-ref res node) (vector-ref res child) (vector-ref count child))))))

  (define (dfs2 node parent)
    (for ([child (vector-ref adj node)])
      (when (not (equal? child parent))
        (vector-set! res child (+ (- (vector-ref res node) (vector-ref count child)) (- n (vector-ref count child))))
        (dfs2 child node)))))

  (dfs 0 -1)
  (dfs2 0 -1)
  (vector->list res))