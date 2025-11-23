#lang racket

(struct ListNode (val next) #:mutable)

(define/contract (odd-even-list head)
  (-> (or/c ListNode null?) (or/c ListNode null?))
  (if (or (null? head) (null? (ListNode-next head)))
      head
      (let ([odd-ptr head]
            [even-ptr (ListNode-next head)]
            [even-head (ListNode-next head)])
        (let loop ([odd-curr odd-ptr]
                   [even-curr even-ptr])
          (if (and (not (null? even-curr)) (not (null? (ListNode-next even-curr))))
              (begin
                (set-ListNode-next! odd-curr (ListNode-next (ListNode-next odd-curr)))
                (set-ListNode-next! even-curr (ListNode-next (ListNode-next even-curr)))
                (loop (ListNode-next odd-curr) (ListNode-next even-curr)))
              (begin
                (set-ListNode-next! odd-curr even-head)
                head))))))