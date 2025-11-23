#lang racket

(define (longest-cycle graph)
  (define n (length graph))
  (define visited (make-vector n -1))
  (define result 0)

  (define (dfs node depth)
    (when (= (vector-ref visited node) -1)
      (vector-set! visited node depth)
      (let ([next (list-ref graph node)])
        (if (and (>= next 0) (< next n))
            (if (= (vector-ref visited next) -1)
                (dfs next (+ depth 1))
                (when (>= (vector-ref visited next) 0)
                  (set! result (max result (- depth (vector-ref visited next) 1))))))
        (vector-set! visited node -1)))

  (for ([i (in-range n)])
    (when (= (vector-ref visited i) -1)
      (dfs i 0)))

  result)