(struct ListNode (val next) #:mutable)

(define (get-node-at lst idx)
  (let loop ((current lst) (i 0))
    (if (= i idx)
        current
        (loop (ListNode-next current) (+ i 1)))))

(define (get-tail lst)
  (let loop ((current lst))
    (if (null? (ListNode-next current))
        current
        (loop (ListNode-next current)))))

(define (merge-in-between list1 a b list2)
  (let* ((node-after-b (ListNode-next (get-node-at list1 b)))
         (list2-tail (get-tail list2)))
    (set-ListNode-next! list2-tail node-after-b)
    (if (= a 0)
        list2
        (let ((node-before-a (get-node-at list1 (- a 1))))
          (set-ListNode-next! node-before-a list2)
          list1))))