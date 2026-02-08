(define-struct TreeNode (val left right))

(define-struct Stack (elements))

(define (make-stack)
  (make-Stack '()))

(define (stack-push! s item)
  (set-Stack-elements! s (cons item (Stack-elements s))))

(define (stack-pop! s)
  (let ([elems (Stack-elements s)])
    (if (empty? elems)
        (error "Stack is empty")
        (begin
          (set-Stack-elements! s (cdr elems))
          (car elems)))))

(define (stack-empty? s)
  (empty? (Stack-elements s)))

(define-struct BSTIterator (stack))

(define (BSTIterator-init root)
  (let ([s (make-stack)])
    (define (push-all-left node)
      (when node
        (stack-push! s node)
        (push-all-left (TreeNode-left node))))
    (push-all-left root)
    (make-BSTIterator s)))

(define (BSTIterator-has-next iter)
  (not (stack-empty? (BSTIterator-stack iter))))

(define (BSTIterator-next iter)
  (let* ([s (BSTIterator-stack iter)]
         [node (stack-pop! s)])
    (define (push-all-left node)
      (when node
        (stack-push! s node)
        (push-all-left (TreeNode-left node))))
    (push-all-left (TreeNode-right node))
    (TreeNode-val node)))