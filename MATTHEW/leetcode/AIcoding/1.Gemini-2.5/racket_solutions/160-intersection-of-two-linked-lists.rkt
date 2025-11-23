(struct ListNode (val next))

(define (get-intersection-node headA headB)
  (let loop ((pA headA) (pB headB))
    (cond
      ((eq? pA pB) pA)
      (else
       (let ((next-pA (ListNode-next pA))
             (next-pB (ListNode-next pB)))
         (loop (if next-pA next-pA (if pB headB #f))
               (if next-pB next-pB (if pA headA #f))))))))