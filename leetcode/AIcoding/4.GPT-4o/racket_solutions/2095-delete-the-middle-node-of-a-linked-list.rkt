#lang racket

(struct ListNode (val next))

(define (deleteMiddle head)
  (if (null? head)
      (void)
      (let loop ((slow head) (fast head) (prev #f))
        (cond
          [(null? fast) (if prev (set-next! prev (next slow)) head)]
          [(null? (next fast)) (if prev (set-next! prev (next slow)) head)]
          [else (loop (next slow) (next (next fast)) slow)])))))

(define (set-next! node new-next)
  (set! (ListNode-next node) new-next))