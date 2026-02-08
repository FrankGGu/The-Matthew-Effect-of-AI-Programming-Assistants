(define-struct ListNode (val next))

(define (insertion-sort-list head)
  (define sorted nil)
  (define (insert node)
    (cond
      [(null? sorted) (set! sorted node)]
      [(< (ListNode-val node) (ListNode-val sorted))
       (set! sorted (ListNode node sorted))]
      [else
       (define current sorted)
       (define prev #f)
       (while (and (not (null? current))
                   (<= (ListNode-val node) (ListNode-val current)))
         (set! prev current)
         (set! current (ListNode-next current)))
       (set! (ListNode-next node) current)
       (if prev
           (set! (ListNode-next prev) node)
           (set! sorted node))]))
  (define current head)
  (while (not (null? current))
    (insert current)
    (set! current (ListNode-next current)))
  sorted)