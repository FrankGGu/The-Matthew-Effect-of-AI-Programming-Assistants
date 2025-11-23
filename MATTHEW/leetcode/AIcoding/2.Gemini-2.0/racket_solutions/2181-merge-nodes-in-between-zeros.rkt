(define (merge-nodes head)
  (let loop ([curr head] [sum 0] [new-head (list)] [tail (list)])
    (cond
      [(null? curr)
       (if (null? new-head)
           null
           (list->list (reverse new-head)))]
      [(zero? (list-ref curr 0))
       (if (zero? sum)
           (loop (list-rest curr) 0 new-head tail)
           (let ([new-node (list sum)])
             (if (null? new-head)
                 (loop (list-rest curr) 0 new-node new-node)
                 (loop (list-rest curr) 0 (append new-head new-node) new-node))))]
      [else
       (loop (list-rest curr) (+ sum (list-ref curr 0)) new-head tail)])))