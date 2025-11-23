#lang racket

(struct ListNode (val next) #:mutable)

(define (delete-duplicates head)
  (let loop ([current head])
    (when (and current (ListNode-next current))
      (if (= (ListNode-val current) (ListNode-val (ListNode-next current)))
          (begin
            (set-ListNode-next! current (ListNode-next (ListNode-next current)))
            (loop current))
          (loop (ListNode-next current)))))
  head)