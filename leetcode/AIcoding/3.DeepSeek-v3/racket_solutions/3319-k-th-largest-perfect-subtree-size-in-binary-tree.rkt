#lang racket

(define (kth-largest-perfect-subtree-size root k)
  (define (perfect-size node)
    (if (null? node)
        (cons 0 0)
        (let* ([left (perfect-size (node-left node))]
               [right (perfect-size (node-right node))]
               [left-size (car left)]
               [right-size (car right)]
               [left-perfect (cdr left)]
               [right-perfect (cdr right)]
               [current-perfect (if (and (= left-size right-size) 
                                        (= left-perfect left-size) 
                                        (= right-perfect right-size))
                                 (+ left-size right-size 1)
                                 0)])
          (cons (+ left-size right-size 1)
                (max current-perfect (max left-perfect right-perfect))))))

  (define perfect-sizes '())
  (define (collect-perfect-sizes node)
    (unless (null? node)
      (let* ([res (perfect-size node)]
             [perfect (cdr res)])
        (when (> perfect 0)
          (set! perfect-sizes (cons perfect perfect-sizes)))
      (collect-perfect-sizes (node-left node))
      (collect-perfect-sizes (node-right node))))

  (collect-perfect-sizes root)
  (if (>= (length perfect-sizes) k)
      (list-ref (sort perfect-sizes >) (- k 1))
      -1))

(define (node-left node) (vector-ref node 1))
(define (node-right node) (vector-ref node 2))