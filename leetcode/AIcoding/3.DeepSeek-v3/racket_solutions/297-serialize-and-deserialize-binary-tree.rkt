(define (make-tree-node val left right) (vector val left right))
(define (tree-node-val node) (vector-ref node 0))
(define (tree-node-left node) (vector-ref node 1))
(define (tree-node-right node) (vector-ref node 2))
(define (tree-node? node) (and (vector? node) (= (vector-length node) 3)))

(define (serialize root)
  (define (helper node)
    (if (not (tree-node? node))
        "null"
        (string-append 
         (number->string (tree-node-val node)) ","
         (helper (tree-node-left node)) ","
         (helper (tree-node-right node)))))
  (helper root))

(define (deserialize data)
  (define lst (string-split data ","))
  (define (helper)
    (if (null? lst)
        #f
        (let ((val (car lst)))
          (set! lst (cdr lst))
          (if (string=? val "null")
              #f
              (make-tree-node (string->number val) (helper) (helper))))))
  (helper))