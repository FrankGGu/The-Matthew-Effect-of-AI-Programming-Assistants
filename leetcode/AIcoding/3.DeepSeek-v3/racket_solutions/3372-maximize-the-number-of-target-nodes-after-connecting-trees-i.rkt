#lang racket

(define (maximize-target-nodes tree1 tree2 target1 target2)
  (define (count-nodes tree target)
    (if (null? tree)
        0
        (if (equal? (car tree) target)
            (+ 1 (count-nodes (cadr tree) target) (count-nodes (caddr tree) target))
            (+ (count-nodes (cadr tree) target) (count-nodes (caddr tree) target)))))

  (define cnt1 (count-nodes tree1 target1))
  (define cnt2 (count-nodes tree2 target2))

  (max cnt1 cnt2))