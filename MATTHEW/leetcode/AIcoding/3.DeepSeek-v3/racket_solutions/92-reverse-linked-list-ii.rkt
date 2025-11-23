(define/contract (reverse-between head left right)
  (-> (or/c list-node? #f) exact-integer? exact-integer? (or/c list-node? #f))
  (if (or (not head) (= left right))
      head
      (let* ([dummy (new list-node% [val 0] [next head])]
             [pre (let loop ([node dummy] [i 1])
                    (if (< i left)
                        (loop (send node get-next) (add1 i))
                        node))]
             [start (send pre get-next)]
             [then (send start get-next)])
        (let loop ([i left] [curr start] [prev pre])
          (if (> i right)
              (begin
                (send pre set-next prev)
                (send start set-next curr)
                (send dummy get-next))
              (let ([next (send curr get-next)])
                (send curr set-next prev)
                (loop (add1 i) next curr)))))))