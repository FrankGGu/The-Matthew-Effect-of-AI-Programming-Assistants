(struct ListNode (val next) #:mutable)

(define (reverse-list head)
  (let loop ((current head)
             (prev null))
    (if (null? current)
        prev
        (let* ((next-node (ListNode-next current)))
          (set-ListNode-next! current prev)
          (loop next-node current)))))