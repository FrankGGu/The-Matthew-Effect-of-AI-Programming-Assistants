(define (good-nodes root)
  (define (helper node max-so-far)
    (cond
      [(null? node) 0]
      [else
       (let ([current-val (car node)]
             [left-node (cadr node)]
             [right-node (caddr node)])
         (let ([is-good (if (>= current-val max-so-far) 1 0)]
               [new-max (max max-so-far current-val)])
           (+ is-good
              (helper left-node new-max)
              (helper right-node new-max))))]))
  (helper root (car root)))