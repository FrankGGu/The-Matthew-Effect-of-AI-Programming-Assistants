#lang racket

(definestruct ListNode (val next))

(define (merge-in-between list1 a b list2)
  (define (helper l count)
    (cond
      [(null? l) (values count null)]
      [(= count a) (values count (list2->node list2))]
      [else (let-values (helper (ListNode-next l) (+ count 1))
              ([new-count new-node])
        (values new-count (ListNode l (if (and (>= new-count b) (not (= new-count b))) new-node (ListNode-next l)))))]))
  (define (list2->node l)
    (if (null? l)
        #f
        (ListNode (ListNode-val l) (list2->node (ListNode-next l)))))
  (define-values (final-count new-head) (helper list1 0))
  new-head)