(define/contract (swap-nodes head k)
  (-> (or/c list-node? #f) exact-integer? (or/c list-node? #f))
  (if (null? head)
      #f
      (let* ([len 0]
             [front-node #f]
             [end-node #f]
             [current head])
        (let loop ([current current])
          (when current
            (set! len (add1 len))
            (cond
              [(= len k) (set! front-node current)]
              [else void])
            (loop (list-node-next current))))
        (set! current head)
        (let loop ([current current] [count 1])
          (when current
            (when (= count (- len k -1))
              (set! end-node current))
            (loop (list-node-next current) (add1 count))))
        (let ([tmp (list-node-val front-node)])
          (set-list-node-val! front-node (list-node-val end-node))
          (set-list-node-val! end-node tmp))
        head)))