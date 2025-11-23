(define/contract (find-tilt root)
  (-> (or/c null? tree-node?) exact-integer?)
  (define (sum-tilt node)
    (if (null? node)
        (cons 0 0)
        (let* ([left (sum-tilt (tree-node-left node))]
               [right (sum-tilt (tree-node-right node))]
               [sum (+ (tree-node-val node) (car left) (car right))]
               [tilt (abs (- (car left) (car right)))])
          (cons sum (+ tilt (cdr left) (cdr right))))))
  (cdr (sum-tilt root)))