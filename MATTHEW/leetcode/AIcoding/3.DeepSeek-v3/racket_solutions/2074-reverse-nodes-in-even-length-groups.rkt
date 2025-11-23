(define/contract (reverse-even-length-groups head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (define (get-length head)
    (let loop ([node head] [len 0])
      (if (not node) len
          (loop (list-node-next node) (add1 len)))))

  (define (reverse-between head m n)
    (let loop ([prev #f] [curr head] [i 1])
      (if (< i m)
          (loop curr (list-node-next curr) (add1 i))
          (let* ([before-m prev]
                 [m-node curr]
                 [tail (let rev-loop ([prev #f] [curr curr] [i i])
                         (if (> i n)
                             prev
                             (let ([next (list-node-next curr)])
                               (set-list-node-next! curr prev)
                               (rev-loop curr next (add1 i)))))]
                 [after-n (list-node-next tail)])
            (set-list-node-next! m-node after-n)
            (if before-m
                (begin (set-list-node-next! before-m tail) head)
                tail)))))

  (let loop ([node head] [group 1] [start 1])
    (if (not node) head
        (let* ([len (get-length node)]
               [group-len (min group len)]
               [end (+ start group-len -1)])
          (if (even? group-len)
              (let ([new-head (reverse-between head start end)])
              (loop (list-node-next node) (add1 group) (add1 end))))))