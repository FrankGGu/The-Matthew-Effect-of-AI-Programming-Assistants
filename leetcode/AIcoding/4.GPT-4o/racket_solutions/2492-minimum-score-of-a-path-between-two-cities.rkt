#lang racket

(define (minScore n roads)
  (define graph (make-hash))
  (for ([road roads])
    (let ([u (first road)]
          [v (second road)]
          [w (third road)])
      (hash-set! graph u (cons (list v w) (hash-ref graph u '())))
      (hash-set! graph v (cons (list u w) (hash-ref graph v '())))))
  (define visited (make-vector n #f))
  (define (dfs node)
    (vector-set! visited (sub1 node) #t)
    (define scores (for/fold ([min-score +inf.0]) ([neighbor (hash-ref graph node)])
                    (min min-score (second neighbor))))
    (for ([neighbor (hash-ref graph node)])
      (define next-node (first neighbor))
      (unless (vector-ref visited (sub1 next-node))
        (set! scores (min scores (dfs next-node))))
      )
    scores)
  (dfs 1))

(define (minScorePaths roads)
  (minScore (apply max (map first (map (lambda (x) (list (first x) (second x))) roads))) roads))