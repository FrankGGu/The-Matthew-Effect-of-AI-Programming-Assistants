(define/contract (reorder-list head)
  (-> (or/c list? null?) void?)
  (if (null? head)
      (void)
      (let* ([nodes (let loop ([node head] [acc '()])
                      (if (null? node)
                          acc
                          (loop (cdr node) (cons node acc))))]
             [len (length nodes)]
             [half (quotient len 2)]
             [stack (take nodes half)])
        (let loop ([node head] [i 0] [stack stack])
          (if (null? stack)
              (set-cdr! node null)
              (let* ([next (cdr node)]
                     [top (car stack)]
                     [rest-stack (cdr stack)])
                (set-cdr! node top)
                (set-cdr! top next)
                (loop next (add1 i) rest-stack))))))