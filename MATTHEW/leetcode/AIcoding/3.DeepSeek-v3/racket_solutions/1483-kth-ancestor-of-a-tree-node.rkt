#lang racket

(define tree-node%
  (class object%
    (super-new)
    (init-field parent)
    (define/public (get-kth-ancestor k)
      (let loop ([node this] [k k])
        (cond
          [(zero? k) node]
          [(not (get-field parent node)) -1]
          [else (loop (get-field parent node) (sub1 k))])))))