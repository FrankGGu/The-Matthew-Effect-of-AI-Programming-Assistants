(define-struct bst-node (val left right) #:transparent #:mutable)

(define (bst-iterator-root root)
  (let ((stack '()))
    (define (push-all node)
      (when node
        (set! stack (cons node stack))
        (push-all (bst-node-left node))))
    (push-all root)
    (lambda ()
      (if (null? stack)
          #f
          (let ((node (car stack)))
            (set! stack (cdr stack))
            (push-all (bst-node-right node))
            (bst-node-val node))))))

(define (make-bst-iterator root)
  (let ((next (bst-iterator-root root)))
  (lambda ()
    (next)))

(define (has-next? iterator)
  (iterator))

(define (next iterator)
  (iterator))