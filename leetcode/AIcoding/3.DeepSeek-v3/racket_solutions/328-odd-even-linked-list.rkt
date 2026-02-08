(define/contract (odd-even-list head)
  (-> (or/c list-node? #f) (or/c list-node? #f))
  (if (or (not head) (not (list-node-next head)))
      head
      (let* ([odd head]
             [even (list-node-next head)]
             [even-head even])
        (let loop ([odd odd] [even even])
          (when (and even (list-node-next even))
            (set-list-node-next! odd (list-node-next (list-node-next odd)))
            (set-list-node-next! even (list-node-next (list-node-next even)))
            (loop (list-node-next odd) (list-node-next even)))
        (set-list-node-next! odd even-head)
        head)))