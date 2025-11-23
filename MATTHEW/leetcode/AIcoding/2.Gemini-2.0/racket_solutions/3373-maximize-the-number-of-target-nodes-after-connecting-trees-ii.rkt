(define (maximize-number-of-target-nodes-after-connecting-trees trees)
  (define (solve trees)
    (define n (length trees))
    (define (get-root tree) (first tree))
    (define (get-children tree) (rest tree))

    (define roots (map get-root trees))
    (define (can-connect? i j) (= (get-root (list-ref trees j)) (last (list-ref trees i))))

    (define memo (make-hash))
    (define (dp mask)
      (hash-ref! memo mask
                 (lambda ()
                   (if (= mask (expt 2 n) -1))
                   (let loop ([i 0] [max-nodes 0])
                     (cond
                       [(>= i n) max-nodes]
                       [(bitwise-bit-set? mask i) (loop (+ i 1) max-nodes)]
                       [else
                        (let* ([tree (list-ref trees i)]
                               [children (get-children tree)]
                               [nodes-in-tree (length children)]
                               [mask-with-i (bitwise-ior mask (expt 2 i))])
                          (let recur ([j 0] [best-nodes max-nodes])
                            (cond
                              [(>= j n) (loop (+ i 1) best-nodes)]
                              [(or (bitwise-bit-set? mask j)
                                   (not (can-connect? i j)))
                               (recur (+ j 1) best-nodes)]
                              [else
                               (let ([mask-with-i-and-j (bitwise-ior mask-with-i (expt 2 j))])
                                 (recur (+ j 1) (max best-nodes (+ nodes-in-tree (dp mask-with-i-and-j))))))
                              ))))))]
                     (loop 0 0))))))
    (dp 0))
  )