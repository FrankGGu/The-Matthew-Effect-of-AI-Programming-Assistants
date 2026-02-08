(define (longest-univalue-path root)
  (define max-len 0)

  (define (helper node)
    (if (null? node)
        0
        (let* ([left (helper (node-left node))]
               [right (helper (node-right node))]
               [left-path (if (and (not (null? (node-left node))) 
                                   (= (node-val node) (node-val (node-left node))))
                              (add1 left)
                              0)]
               [right-path (if (and (not (null? (node-right node))) 
                                    (= (node-val node) (node-val (node-right node))))
                               (add1 right)
                               0)])
          (set! max-len (max max-len (+ left-path right-path)))
          (max left-path right-path))))

  (helper root)
  max-len)