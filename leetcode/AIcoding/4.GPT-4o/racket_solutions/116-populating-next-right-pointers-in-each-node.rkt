(define-type Node
  (struct Node (val left right next)))

(define (connect root)
  (if (null? root)
      root
      (begin
        (define (connect-level left right)
          (if (and left right)
              (begin
                (set-node-next! left right)
                (connect-level (Node-left left) (Node-right left))
                (connect-level (Node-left right) (Node-right right))
                (connect-level (Node-right left) (Node-left right))))
          ))
        (connect-level (Node-left root) (Node-right root))
        root)))

(define (set-node-next! node next-node)
  (set-field! node 'next next-node))

(define (set-field! struct field value)
  (set! (struct-field struct field) value))