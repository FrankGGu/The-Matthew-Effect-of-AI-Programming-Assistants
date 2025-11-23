#lang racket

(define-struct: ListNode (val next) #:transparent)
(define-struct: TreeNode (val left right) #:transparent)

(define (sorted-list-to-bst head)
  (define (get-middle node)
    (let loop ((slow node) (fast node))
      (if (or (not fast) (not (ListNode-next fast)))
          slow
          (loop (ListNode-next slow) (ListNode-next (ListNode-next fast))))))

  (define (convert left right)
    (if (> (ListNode-val left) (ListNode-val right))
        #f
        (let* ((mid (get-middle left))
               (root (TreeNode (ListNode-val mid) #f #f))
               (right-part (ListNode-next mid)))
          (set-TreeNode-left! root (convert left mid))
          (set-TreeNode-right! root (convert right-part right))
          root)))

  (if (not head)
      #f
      (convert head (let loop ((node head))
                      (if (not (ListNode-next node))
                          node
                          (loop (ListNode-next node)))))))