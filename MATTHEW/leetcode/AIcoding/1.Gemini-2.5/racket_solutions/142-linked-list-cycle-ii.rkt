#lang racket

(provide (struct-out ListNode) detectCycle)

(struct ListNode (val next) #:transparent)

(define (detectCycle head)
  (let loop ((slow head) (fast head))
    (cond
      ((or (null? fast) (null? (ListNode-next fast)))
       null)
      (else
       (let* ((new-slow (ListNode-next slow))
              (new-fast (ListNode-next (ListNode-next fast))))
         (if (eq? new-slow new-fast)
             (let find-start ((p1 head) (p2 new-slow))
               (if (eq? p1 p2)
                   p1
                   (find-start (ListNode-next p1) (ListNode-next p2))))
             (loop new-slow new-fast)))))))