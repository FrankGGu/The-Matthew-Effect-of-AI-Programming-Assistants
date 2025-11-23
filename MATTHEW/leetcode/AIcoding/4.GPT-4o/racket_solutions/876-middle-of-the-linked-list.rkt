(define-type ListNode
  (struct ListNode (val next)))

(define (middleNode head)
  (define slow head)
  (define fast head)
  (while (and fast (next fast))
    (set! slow (next slow))
    (set! fast (next (next fast))))
  slow)