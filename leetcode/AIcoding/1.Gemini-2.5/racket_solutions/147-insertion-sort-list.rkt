(struct ListNode (val next) #:mutable)

(define (insertion-sort-list head)
  (define dummy (ListNode -1 #f)) ; Dummy head for the sorted list

  (let loop ((current head))
    (when current
      (let* ((next-original (ListNode-next current))) ; Save next node from original list

        ;; Find insertion point in the sorted list (starting from dummy)
        (let find-pos ((prev-sorted dummy)
                       (walker-sorted (ListNode-next dummy)))
          (cond
            ((not walker-sorted) ; Reached end of sorted list
             (set-ListNode-next! prev-sorted current)
             (set-ListNode-next! current #f)) ; Detach current from its original next
            ((< (ListNode-val current) (ListNode-val walker-sorted)) ; Found insertion point
             (set-ListNode-next! prev-sorted current)
             (set-ListNode-next! current walker-sorted))
            (else ; Continue searching
             (find-pos walker-sorted (ListNode-next walker-sorted)))))
        (loop next-original)))) ; Process the next node from the original list
  (ListNode-next dummy))