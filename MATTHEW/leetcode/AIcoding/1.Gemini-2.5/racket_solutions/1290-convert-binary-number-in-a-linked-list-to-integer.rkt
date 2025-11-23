(define-struct ListNode (val next))

(define (get-decimal-value head)
  (let loop ((current head)
             (accumulator 0))
    (if (null? current)
        accumulator
        (loop (ListNode-next current)
              (+ (* accumulator 2) (ListNode-val current))))))