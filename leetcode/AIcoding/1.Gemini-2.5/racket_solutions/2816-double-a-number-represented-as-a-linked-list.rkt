(define-struct ListNode (val next) #:mutable)

(define/contract (double-it head)
  (-> (or/c ListNode #f) (or/c ListNode #f))

  (define (double-and-carry node)
    (if (not node)
        0
        (let* ([carry-from-next (double-and-carry (ListNode-next node))]
               [new-val (+ (* (ListNode-val node) 2) carry-from-next)]
               [current-digit (modulo new-val 10)]
               [current-carry (quotient new-val 10)])
          (set-ListNode-val! node current-digit)
          current-carry)))

  (let ([final-carry (double-and-carry head)])
    (if (> final-carry 0)
        (ListNode final-carry head)
        head)))