(define-struct ListNode (val next))

(define (delete-duplicates head)
  (define dummy (ListNode 0 head))
  (define prev dummy)
  (define current head)

  (let loop ()
    (when current
      (if (and (ListNode-next current)
               (= (ListNode-val current) (ListNode-val (ListNode-next current))))
          (begin
            (let dup-loop ((temp-current current))
              (if (and (ListNode-next temp-current)
                       (= (ListNode-val temp-current) (ListNode-val (ListNode-next temp-current))))
                  (dup-loop (ListNode-next temp-current))
                  (set! current (ListNode-next temp-current))))
            (set-ListNode-next! prev current)
            (loop))
          (begin
            (set! prev current)
            (set! current (ListNode-next current))
            (loop)))))

  (ListNode-next dummy))