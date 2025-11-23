(struct node (val left right next) #:mutable #:transparent)

(define (connect root)
  (if (null? root)
      root
      (let loop ([q (list root)])
        (if (empty? q)
            root
            (let* ([n (length q)]
                   [new-q (list)])
              (for ([i (in-range n)])
                (let* ([curr (list-ref q i)]
                       [next-node (if (= i (- n 1))
                                      #f
                                      (list-ref q (+ i 1)))])
                  (set-node-next! curr next-node)
                  (when (node-left curr)
                    (set! new-q (append new-q (list (node-left curr)))))
                  (when (node-right curr)
                    (set! new-q (append new-q (list (node-right curr)))))))
              (loop new-q))))))