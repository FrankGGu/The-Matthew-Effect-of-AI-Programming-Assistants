#lang racket

(define-struct ListNode (val next))

(define (reorder-list head)
  (unless (or (null? head) (null? (ListNode-next head)))
    ; Step 1: Find the middle of the list
    ; slow moves one step, fast moves two steps.
    ; prev tracks the node before slow, to break the list.
    (let loop-middle ((slow head) (fast head) (prev null))
      (if (or (null? fast) (null? (ListNode-next fast)))
          ; fast reached the end, slow is at the start of the second half
          (let* ((head1 head)
                 (head2 slow))
            ; Step 2: Split the list into two halves
            ; Break the link between the first half and the second half
            (when prev
              (set-ListNode-next! prev null))

            ; Step 3: Reverse the second half
            (define (reverse-list node)
              (let loop ((curr node) (prev-node null))
                (if (null? curr)
                    prev-node
                    (let ((next-node (ListNode-next curr)))
                      (set-ListNode-next! curr prev-node)
                      (loop next-node curr)))))
            (let ((reversed-head2 (reverse-list head2)))

              ; Step 4: Merge the two halves alternately
              ; head1: L0 -> L1 -> L2 ...
              ; reversed-head2: Ln -> Ln-1 -> Ln-2 ...
              ; Result: L0 -> Ln -> L1 -> Ln-1 -> L2 -> Ln-2 ...
              (let loop-merge ((p1 head1) (p2 reversed-head2))
                (unless (or (null? p1) (null? p2))
                  (let ((p1-next (ListNode-next p1)) ; Store original next of p1
                        (p2-next (ListNode-next p2))) ; Store original next of p2
                    (set-ListNode-next! p1 p2) ; Link p1 to p2
                    (if (null? p1-next)
                        ; If p1 was the last node of the first half,
                        ; p2's next should naturally point to its original next (p2-next),
                        ; which correctly appends the rest of the second list.
                        (void)
                        ; Otherwise, link p2 to the original next of p1
                        (set-ListNode-next! p2 p1-next))
                    ; Advance to the next pair of nodes
                    (loop-merge p1-next p2-next))))))
          ; Continue finding the middle
          (loop-middle (ListNode-next slow) (ListNode-next (ListNode-next fast)) slow))))
  (void)) ; The problem requires modifying in-place and returning void.