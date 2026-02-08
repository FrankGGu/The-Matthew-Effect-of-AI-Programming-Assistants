#lang racket

(struct ListNode (val next) #:mutable)

(define (delete-node node)
  ;; Copy the value from the next node to the current node
  (set-ListNode-val! node (ListNode-val (ListNode-next node)))
  ;; Make the current node's next pointer skip the next node (which we just copied)
  (set-ListNode-next! node (ListNode-next (ListNode-next node))))