#lang racket

(define (num-color root)
  (let ([colors (mutable-set)])
    (let loop ([node root])
      (when node
        (set-add! colors (first node))
        (loop (second node))
        (loop (third node))))
    (set-count colors)))