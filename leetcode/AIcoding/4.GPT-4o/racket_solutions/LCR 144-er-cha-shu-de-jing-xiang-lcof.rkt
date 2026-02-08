(define (invertTree root)
  (if (null? root)
      null
      (let* ([left (invertTree (left root))]
             [right (invertTree (right root))]
             [new-root (make-node (value root) right left)])
        new-root)))

(define (make-node val left right)
  (list 'node val left right))

(define (value node)
  (second node))

(define (left node)
  (third node))

(define (right node)
  (fourth node))