(define/contract (min-cost start home rowCosts colCosts)
  (-> (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let* ([start-row (first start)]
         [start-col (second start)]
         [home-row (first home)]
         [home-col (second home)]
         [row-dir (if (> home-row start-row) 1 -1)]
         [col-dir (if (> home-col start-col) 1 -1)]
         [row-cost (for/sum ([r (in-range start-row home-row row-dir)])
                    (list-ref rowCosts (if (> row-dir 0) (+ r 1) r)))]
         [col-cost (for/sum ([c (in-range start-col home-col col-dir)])
                    (list-ref colCosts (if (> col-dir 0) (+ c 1) c))) )])
    (+ row-cost col-cost)))