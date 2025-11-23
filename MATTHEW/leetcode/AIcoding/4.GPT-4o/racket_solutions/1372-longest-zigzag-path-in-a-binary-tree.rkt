(define (longest-zigzag root)
  (define (zigzag-helper node is-left length)
    (if (null? node)
        length
        (max (zigzag-helper (if is-left (tree-right node) (tree-left node)) (not is-left) (+ length 1))
             (zigzag-helper (if is-left (tree-left node) (tree-right node)) is-left 1))))
  (max (zigzag-helper root #t 0) (zigzag-helper root #f 0)))

(define (tree-left t) (if (null? t) #f (tree-left-helper t)))
(define (tree-left-helper t) (if (null? t) #f (car (cdr t))))
(define (tree-right t) (if (null? t) #f (tree-right-helper t)))
(define (tree-right-helper t) (if (null? t) #f (cadr (cdr t))))