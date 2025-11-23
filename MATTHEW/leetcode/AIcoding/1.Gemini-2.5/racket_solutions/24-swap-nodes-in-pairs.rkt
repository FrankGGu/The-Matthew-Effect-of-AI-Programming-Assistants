(define-struct ListNode (val next) #:mutable)

(define (swap-pairs head)
  (cond
    [(or (not head) (not (ListNode-next head)))
     ;; Base case: 0 or 1 node, no swap needed.
     head]
    [else
     ;; Recursive case: at least 2 nodes.
     (define first head)
     (define second (ListNode-next head))

     ;; The 'first' node's next pointer should point to the result of swapping
     ;; the rest of the list (starting from the node after 'second').
     (set-ListNode-next! first (swap-pairs (ListNode-next second)))

     ;; The 'second' node's next pointer should point to the 'first' node.
     (set-ListNode-next! second first)

     ;; The 'second' node is now the new head of this swapped pair.
     second]))