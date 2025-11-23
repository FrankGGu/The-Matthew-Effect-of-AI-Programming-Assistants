(define/contract (projection-area grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([n (length grid)]
         [xy (for*/sum ([row (in-list grid)]
                        [val (in-list row)])
               (if (> val 0) 1 0))]
         [xz (for/sum ([row (in-list grid)])
               (apply max row))]
         [yz (for/sum ([j (in-range n)])
               (apply max (for/list ([i (in-range n)]) (list-ref (list-ref grid i) j)))))])
    (+ xy xz yz)))