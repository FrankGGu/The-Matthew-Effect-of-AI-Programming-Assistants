#lang racket

(define/contract (delete-nodes head nums)
  (-> (or/c ListNode? #f) (listof exact-integer?) (or/c ListNode? #f))
  (define nums-set (list->set nums))
  (define (helper prev curr)
    (cond
      [(not curr) #f]
      [(set-member? nums-set (ListNode-val curr))
       (helper prev (ListNode-next curr))]
      [else
       (if prev
           (begin
             (set-ListNode-next! prev (ListNode-next curr))
             (helper prev (ListNode-next curr)))
           (begin
             (set-ListNode-next! curr (ListNode-next curr))
             (helper curr (ListNode-next curr))))]))
  (let ([dummy (make-ListNode -1)])
    (set-ListNode-next! dummy head)
    (helper dummy head)
    (ListNode-next dummy)))