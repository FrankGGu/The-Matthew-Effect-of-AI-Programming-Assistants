#lang racket

(define (smallest-missing-genetic-value-in-each-subtree root)
  (define-values (g) (make-hash))
  (define (dfs node)
    (when node
      (hash-set! g (car node) (cdr node))
      (dfs (cadr node))
      (dfs (caddr node))))
  (dfs root)
  (define n (hash-count g))
  (define res (make-vector n 1))
  (define visited (make-hash))
  (define (find-genes node)
    (when (and node (not (hash-has-key? visited node)))
      (hash-set! visited node #t)
      (vector-set! res (sub1 node) (if (= (hash-ref g node) 1) 1 (vector-ref res (sub1 node))))
      (find-genes (cadr node))
      (find-genes (caddr node))))
  (define (dfs2 node)
    (when node
      (when (hash-has-key? visited node)
        (vector-set! res (sub1 node) (if (= (hash-ref g node) 1) 1 (vector-ref res (sub1 node)))))
      (dfs2 (cadr node))
      (dfs2 (caddr node))))
  (define (find-ancestor node)
    (when node
      (when (hash-has-key? visited node)
        (vector-set! res (sub1 node) (if (= (hash-ref g node) 1) 1 (vector-ref res (sub1 node)))))
      (find-ancestor (cadr node))
      (find-ancestor (caddr node))))
  (define (get-parents node)
    (cond [(null? node) '()]
          [else
           (append (get-parents (cadr node)) (get-parents (caddr node)) (list node))]))
  (define (find-missing)
    (let loop ([i 1] [missing 1])
      (if (>= i n) res
          (if (member i (hash-values g)) (loop (+ i 1) missing) (vector-set! res (sub1 i) missing)))))
  (find-genes 1)
  (dfs2 1)
  (find-ancestor 1)
  (find-missing)
  (vector->list res))