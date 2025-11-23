(define (bst-iterator root)
  (let* ([stack (list)]
         (push (lambda (node)
                 (let loop ([n node])
                   (cond [(null? n) void]
                         [else (begin
                                 (set! stack (cons n stack))
                                 (loop (->left n))))))))
         (next! (lambda ()
                  (if (null? stack)
                      #f
                      (let* ([node (car stack)])
                        (set! stack (cdr stack))
                        (push (->right node))
                        (->val node)))))
         (has-next? (lambda ()
                       (not (null? stack)))))
    (begin
      (push root)
      (struct bst-iterator-struct (next has-next) #:mutable)
      (bst-iterator-struct next! has-next?))))