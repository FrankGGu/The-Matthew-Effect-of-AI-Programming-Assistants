#lang racket

(define (cycle-length-queries n queries)
  (define (get-depth u parent depth)
    (if (null? parent)
        depth
        (let ((p (car parent)))
          (if (= p u)
              depth
              (get-depth u (cdr parent) (add1 depth))))))

  (define (lca u v depth-u depth-v)
    (cond ((= u v) u)
          ((> depth-u depth-v) (lca (parent u) v depth-u (sub1 depth-v)))
          ((< depth-u depth-v) (lca u (parent v) (sub1 depth-u) depth-v))
          (else (lca (parent u) (parent v) (sub1 depth-u) (sub1 depth-v)))))

  (define (solve u v)
    (let* ((depth-u (get-depth u '() 0))
           (depth-v (get-depth v '() 0))
           (lca-node (lca u v depth-u depth-v))
           (depth-lca (get-depth lca-node '() 0)))
      (+ (- depth-u depth-lca) (- depth-v depth-lca))))

  (map solve queries))