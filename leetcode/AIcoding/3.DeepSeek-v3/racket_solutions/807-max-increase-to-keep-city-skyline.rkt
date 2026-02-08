(define/contract (max-increase-keeping-skyline grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([n (length grid)]
         [row-max (for/list ([row grid]) (apply max row))]
         [col-max (for/list ([i (in-range n)]) 
                    (apply max (for/list ([row grid]) (list-ref row i))))])
    (for/sum ([i (in-range n)])
      (for/sum ([j (in-range n)])
        (- (min (list-ref row-max i) (list-ref col-max j)) 
           (list-ref (list-ref grid i) j))))))