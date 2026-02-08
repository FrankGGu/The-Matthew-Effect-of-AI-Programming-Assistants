(define-type TreeNode
  (struct TreeNode (val left right)))

(define (serialize root)
  (define (helper node)
    (if (null? node)
        "#"
        (string-append (number->string (TreeNode-val node)) ","
                       (helper (TreeNode-left node)) ","
                       (helper (TreeNode-right node)))))
  (helper root))

(define (deserialize data)
  (define (helper nodes)
    (if (equal? (car nodes) "#")
        (begin (set! nodes (cdr nodes)) #f)
        (begin
          (define val (string->number (car nodes)))
          (set! nodes (cdr nodes))
          (define left (helper nodes))
          (define right (helper nodes))
          (TreeNode val left right))))
  (helper (string-split data #\,)))

(define (TreeNode val left right)
  (list val left right))

(define (TreeNode-val node)
  (car node))

(define (TreeNode-left node)
  (cadr node))

(define (TreeNode-right node)
  (caddr node))