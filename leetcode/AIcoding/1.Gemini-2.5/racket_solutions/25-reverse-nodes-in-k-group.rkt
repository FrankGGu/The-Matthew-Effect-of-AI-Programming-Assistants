(define-struct ListNode (val next) #:mutable)

(define (reverse-k-group head k)
  (define (get-kth-node start k)
    (let loop ((node start) (i 1))
      (if (or (null? node) (> i k))
          null
          (if (= i k)
              node
              (loop (ListNode-next node) (+ i 1))))))

  (define (reverse-segment head tail)
    (let loop ((prev null) (curr head))
      (if (eq? curr (ListNode-next tail))
          (cons tail head)
          (let ((next-node (ListNode-next curr)))
            (set-ListNode-next! curr prev)
            (loop curr next-node)))))

  (let* ((dummy (ListNode 0 head))
         (prev-group-end dummy))

    (let loop ()
      (let* ((current-group-head (ListNode-next prev-group-end))
             (group-end (get-kth-node current-group-head k)))

        (when (null? group-end)
          (void))

        (unless (null? group-end)
          (let* ((next-group-start (ListNode-next group-end)))
            (set-ListNode-next! group-end null)

            (let-values (((new-head new-tail) (reverse-segment current-group-head group-end)))
              (set-ListNode-next! prev-group-end new-head)
              (set-ListNode-next! new-tail next-group-start)

              (set! prev-group-end new-tail)

              (loop))))))

    (ListNode-next dummy)))