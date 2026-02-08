#lang racket

(struct TreeNode (val left right))

(define (calculate-swaps level-values)
  (define n (length level-values))
  (if (<= n 1)
      0
      (begin
        (define current-arr (list->vector level-values))
        (define sorted-arr (sort level-values <))

        (define val->target-idx (make-hash))
        (for ([val sorted-arr] [idx (range n)])
          (hash-set! val->target-idx val idx))

        (define visited (make-vector n #f))
        (define level-swaps 0)

        (for ([i (range n)])
          (unless (vector-ref visited i)
            (define cycle-len 0)
            (define current-idx i)
            (let loop ()
              (unless (vector-ref visited current-idx)
                (vector-set! visited current-idx #t)
                (set! cycle-len (+ cycle-len 1))
                (define val-at-current-idx (vector-ref current-arr current-idx))
                (define target-idx (hash-ref val->target-idx val-at-current-idx))
                (set! current-idx target-idx)
                (loop)))
            (when (> cycle-len 0)
              (set! level-swaps (+ level-swaps (- cycle-len 1))))))
        level-swaps)))

(define (minimum-operations-to-sort-a-binary-tree-by-level root)
  (if (null? root)
      0
      (begin
        (define total-swaps 0)
        (define q (list root))

        (let loop-bfs ([current-q q])
          (unless (empty? current-q)
            (define next-q-rev '())
            (define current-level-values-rev '())

            (for ([node current-q])
              (set! current-level-values-rev (cons (TreeNode-val node) current-level-values-rev))
              (when (TreeNode-left node)
                (set! next-q-rev (cons (TreeNode-left node) next-q-rev)))
              (when (TreeNode-right node)
                (set! next-q-rev (cons (TreeNode-right node) next-q-rev))))

            (define current-level-values (reverse current-level-values-rev))
            (define next-q (reverse next-q-rev))

            (set! total-swaps (+ total-swaps (calculate-swaps current-level-values)))
            (loop-bfs next-q)))

        total-swaps)))