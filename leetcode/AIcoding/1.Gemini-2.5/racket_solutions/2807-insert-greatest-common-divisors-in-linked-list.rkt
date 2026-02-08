(define-struct (ListNode #:mutable) (val next))

(require racket/math)

(define (insert-gcd-nodes head)
  (let loop ((current head))
    (when (and current (ListNode-next current))
      (let* ((next-node (ListNode-next current))
             (gcd-val (gcd (ListNode-val current) (ListNode-val next-node)))
             (new-node (struct:ListNode gcd-val next-node)))
        (set-ListNode-next! current new-node)
        (loop (ListNode-next new-node))))
  head)