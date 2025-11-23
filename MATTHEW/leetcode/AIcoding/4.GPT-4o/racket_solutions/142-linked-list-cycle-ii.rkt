#lang racket

(struct ListNode (val next))

(define (detectCycle head)
  (define slow head)
  (define fast head)

  (define (has-cycle?)
    (when fast
      (set! fast (ListNode-next fast))
      (set! slow (ListNode-next slow))
      (if (equal? slow fast)
          #t
          (has-cycle?))))

  (if (has-cycle?)
    (begin
      (set! slow head)
      (define (find-start)
        (if (equal? slow fast)
            slow
            (begin
              (set! slow (ListNode-next slow))
              (set! fast (ListNode-next fast))
              (find-start))))
      (find-start))
    #f))