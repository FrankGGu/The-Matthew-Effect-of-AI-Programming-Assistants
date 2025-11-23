(define (reverse-list head)
  (let loop ([prev null] [curr head])
    (if (null? curr)
        prev
        (let* ([next-node (cdr curr)])
          (set-cdr! curr prev)
          (loop curr next-node)))))