#lang racket

(struct list-node (val next) #:mutable)

(define (reverse-between head left right)
  (define dummy (list-node #f head))
  (define pre-left dummy)

  ;; Move pre-left to the node immediately before the 'left'-th node
  (for ([_ (range (- left 1))])
    (set! pre-left (list-node-next pre-left)))

  ;; 'start' is the 'left'-th node, which will become the tail of the reversed segment
  (define start (list-node-next pre-left))

  ;; Pointers for reversing the sublist
  (define current start)
  (define prev null)

  ;; Reverse the sublist from 'left' to 'right'
  ;; This loop runs 'right - left + 1' times
  (for ([_ (range (+ (- right left) 1))])
    (define next-node (list-node-next current))
    (set-list-node-next! current prev)
    (set! prev current) ; 'prev' becomes the new head of the reversed segment in each step
    (set! current next-node)) ; 'current' moves to the next node to be reversed or to the node after 'right'

  ;; Connect the parts of the list
  ;; 1. Connect the node before 'left' to the new head of the reversed segment ('prev')
  (set-list-node-next! pre-left prev)

  ;; 2. Connect the tail of the reversed segment ('start', which was the original 'left'-th node)
  ;;    to the node immediately after the 'right'-th node ('current')
  (set-list-node-next! start current)

  ;; The head of the modified list is dummy.next
  (list-node-next dummy))