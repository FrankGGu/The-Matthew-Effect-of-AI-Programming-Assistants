#lang racket

(define (sum-of-distances-in-tree N edges)
  (define adj (make-vector N null))
  (for-each (lambda (edge)
              (define u (car edge))
              (define v (cadr edge))
              (vector-set! adj u (cons v (vector-ref adj u)))
              (vector-set! adj v (cons u (vector-ref adj v))))
            edges)

  (define dp-count (make-vector N 0))
  (define dp-sum-dist (make-vector N 0))
  (define ans (make-vector N 0))

  (define (dfs1 u p)
    (vector-set! dp-count u 1)
    (vector-set! dp-sum-dist u 0)
    (for-each (lambda (v)
                (when (not (= v p))
                  (dfs1 v u)
                  (vector-set! dp-count u (+ (vector-ref dp-count u) (vector-ref dp-count v)))
                  (vector-set! dp-sum-dist u (+ (vector-ref dp-sum-dist u)
                                                (vector-ref dp-sum-dist v)
                                                (vector-ref dp-count v)))))
              (vector-ref adj u)))

  (define (dfs2 u p)
    (for-each (lambda (v)
                (when (not (= v p))
                  (vector-set! ans v
                               (+ (vector-ref ans u)
                                  (- N (* 2 (vector-ref dp-count v)))))
                  (dfs2 v u)))
              (vector-ref adj u)))

  (dfs1 0 -1)
  (vector-set! ans 0 (vector-ref dp-sum-dist 0))
  (dfs2 0 -1)

  (vector->list ans))