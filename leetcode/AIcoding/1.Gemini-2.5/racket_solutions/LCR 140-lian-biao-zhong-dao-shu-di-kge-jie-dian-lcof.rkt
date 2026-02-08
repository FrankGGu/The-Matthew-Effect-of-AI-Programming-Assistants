(define-struct ListNode (val next) #:mutable)

(define (double-it head)
  (define (double-recursive node)
    (if (null? node)
        0
        (let* ((carry-from-next (double-recursive (ListNode-next node)))
               (current-val (ListNode-val node))
               (new-val (+ (* 2 current-val) carry-from-next)))
          (set-ListNode-val! node (modulo new-val 10))
          (quotient new-val 10))))

  (let ((initial-carry (double-recursive head)))
    (if (> initial-carry 0)
        (ListNode initial-carry head)
        head)))