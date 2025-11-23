(define (get-intersection-node headA headB)
  (let loop ((pA headA)
             (pB headB))
    (cond
      ;; If pA and pB are the same object (node), that's the intersection.
      ;; This covers the case where they meet at an intersection node,
      ;; or both become null (meaning no intersection).
      ((eq? pA pB) pA)
      ;; Otherwise, advance both pointers.
      ;; If a pointer is null, it means it reached the end of its current path,
      ;; so wrap it to the head of the *other* list.
      (else
       (let ((next-pA (if (null? pA) headB (ListNode-next pA)))
             (next-pB (if (null? pB) headA (ListNode-next pB))))
         (loop next-pA next-pB))))))