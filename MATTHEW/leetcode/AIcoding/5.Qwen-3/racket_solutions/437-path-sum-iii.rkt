#lang racket

(define (path-sum-iii root target)
  (define (dfs node prefix sum)
    (if (not node) 0
        (+ (if (= (- sum prefix) target) 1 0)
           (dfs (node-left node) (+ prefix (node-val node)) sum)
           (dfs (node-right node) (+ prefix (node-val node)) sum))))

  (define (traverse node)
    (if (not node) 0
        (+ (dfs node 0 0)
           (traverse (node-left node))
           (traverse (node-right node)))))

  (traverse root))

(define (make-tree lst)
  (define (helper lst i)
    (if (>= i (length lst)) #f
        (if (eqv? (list-ref lst i) 'null) #f
            (make-node (list-ref lst i)
                       (helper lst (* 2 (+ i 1)))
                       (helper lst (+ 1 (* 2 (+ i 1))))))))
  (helper lst 0))

(define (main)
  (define input (read))
  (define root (make-tree input))
  (define target (read))
  (printf "~a\n" (path-sum-iii root target)))

(main)