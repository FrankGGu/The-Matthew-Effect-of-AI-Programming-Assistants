(define (reverse-list head)
  (let loop ((prev #f)
             (current head))
    (if (not current)
        prev
        (let* ((next-temp (ListNode-next current)))
          (set-ListNode-next! current prev)
          (loop current next-temp)))))