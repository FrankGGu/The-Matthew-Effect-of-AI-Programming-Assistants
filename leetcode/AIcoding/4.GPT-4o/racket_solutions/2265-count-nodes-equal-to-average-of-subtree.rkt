#lang racket
(define (countNodesEqualToAverage root)
  (define (helper node)
    (if (null? node)
        (values 0 0)
        (let-values ([(left-count left-sum) (helper (node-left node))]
                     [(right-count right-sum) (helper (node-right node))])
          (define total-sum (+ (node-val node) left-sum right-sum))
          (define total-count (+ 1 left-count right-count))
          (define avg (quotient total-sum total-count))
          (define is-equal (if (= (node-val node) avg) 1 0))
          (values (+ is-equal left-count right-count) total-sum)))))

  (define-values (count _) (helper root))
  count)

(define (node-val node) (if node (node-val* node)))
(define (node-left node) (if node (node-left* node)))
(define (node-right node) (if node (node-right* node)))