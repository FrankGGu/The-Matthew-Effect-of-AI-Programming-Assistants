(define (flatten head)
  (define (flatten-helper node)
    (cond
      [(null? node) (void)]
      [else
       (let* ([next-node (-> node next)]
              [child-node (-> node child)])
         (when (not (null? child-node))
           (let* ([tail (let loop ([n child-node])
                            (cond
                              [(null? (-> n next)) n]
                              [else (loop (-> n next))]))]
                  [_ (set! (-> node child) #f)]
                  [_ (set! (-> node next) child-node)]
                  [_ (set! (-> child-node prev) node)])
             (when (not (null? next-node))
               (set! (-> tail next) next-node)
               (set! (-> next-node prev) tail)))
           (flatten-helper next-node))
         (flatten-helper next-node))]))
  (flatten-helper head)
  head)