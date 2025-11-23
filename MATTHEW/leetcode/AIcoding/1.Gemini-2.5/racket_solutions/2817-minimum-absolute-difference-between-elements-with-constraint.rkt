#lang racket
(require data-structure/red-black-tree)

(define (min-absolute-difference nums x)
  (let* ([n (length nums)]
         [nums-vec (list->vector nums)]
         [min-diff (expt 10 10)]
         [s (rbtree-empty <)])
    (for ([j (in-range n)])
      (when (>= (- j x) 0)
        (set! s (rbtree-insert s (vector-ref nums-vec (- j x)))))

      (let ([current-val (vector-ref nums-vec j)])
        (let ([ge-node (rbtree-successor s current-val)])
          (when ge-node
            (set! min-diff (min min-diff (- (rbtree-node-key ge-node) current-val)))))

        (let ([le-node (rbtree-predecessor s current-val)])
          (when le-node
            (set! min-diff (min min-diff (- current-val (rbtree-node-key le-node))))))
        ))
    min-diff))