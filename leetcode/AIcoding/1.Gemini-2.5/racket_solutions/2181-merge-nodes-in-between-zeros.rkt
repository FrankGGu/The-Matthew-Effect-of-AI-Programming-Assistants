(define-struct ListNode (val next))

(define (merge-nodes head)
  (let ([current (ListNode-next head)])
    (let loop ([curr current]
               [current-sum 0])
      (cond
        [(null? curr) null]
        [(= (ListNode-val curr) 0)
         (ListNode current-sum
                   (loop (ListNode-next curr) 0))]
        [else
         (loop (ListNode-next curr) (+ current-sum (ListNode-val curr)))]))))