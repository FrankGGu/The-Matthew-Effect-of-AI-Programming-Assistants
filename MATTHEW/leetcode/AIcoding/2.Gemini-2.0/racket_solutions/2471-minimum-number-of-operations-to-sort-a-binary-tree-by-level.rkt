(define (minimum-operations-to-sort-by-level root)
  (if (null? root)
      0
      (let loop ([q (make-queue)] [level-ops 0])
        (queue-enqueue! q root)
        (let inner-loop ()
          (if (queue-empty? q)
              level-ops
              (let* ([level-size (queue-size q)]
                     [level-nodes (for/list ([i (in-range level-size)])
                                     (let ([node (queue-dequeue! q)])
                                       (when (node-left node) (queue-enqueue! q (node-left node)))
                                       (when (node-right node) (queue-enqueue! q (node-right node)))
                                       (node-val node)))
                     [sorted-level-nodes (sort level-nodes <)]
                     [ops (let count-swaps ([arr level-nodes] [swaps 0])
                            (if (empty? arr)
                                swaps
                                (let* ([first-val (first arr)]
                                       [index (index-of first-val sorted-level-nodes)]
                                       [rest (rest arr)])
                                  (if (= index 0)
                                      (count-swaps rest swaps)
                                      (let* ([new-rest (remove-at index rest)]
                                             [new-arr (cons (list-ref sorted-level-nodes 0) new-rest)])
                                        (count-swaps new-arr (+ swaps 1))))))))])
                (inner-loop)
                (loop q (+ level-ops ops))))))))

(define (index-of val lst)
  (let loop ([lst lst] [index 0])
    (cond
      [(empty? lst) #f]
      [(= (first lst) val) index]
      [else (loop (rest lst) (+ index 1))])))

(define (remove-at index lst)
  (cond
    [(= index 0) (rest lst)]
    [else (cons (first lst) (remove-at (- index 1) (rest lst)))]))

(define node-val car)
(define node-left cadr)
(define node-right caddr)