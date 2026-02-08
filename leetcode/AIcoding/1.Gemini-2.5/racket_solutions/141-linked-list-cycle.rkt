(define (has-cycle head)
  (if (null? head)
      #f
      (let loop ((slow head) (fast head))
        (let ((next-slow (ListNode-next slow))
              (next-fast (ListNode-next fast)))
          (cond
            ((or (null? next-fast) (null? (ListNode-next next-fast)))
             #f)
            (else
             (let ((new-slow next-slow)
                   (new-fast (ListNode-next next-fast)))
               (if (eq? new-slow new-fast)
                   #t
                   (loop new-slow new-fast)))))))))