(define (average-of-subtree root)
  (let ([count 0])
    (define (helper node)
      (if (null? node)
          (cons 0 0)
          (let* ([left (helper (node-left node))]
                 [right (helper (node-right node))]
                 [sum (+ (node-val node) (car left) (car right))]
                 [num-nodes (+ 1 (cdr left) (cdr right))])
            (if (= (node-val node) (quotient sum num-nodes))
                (set! count (add1 count)))
            (cons sum num-nodes))))
    (helper root)
    count))