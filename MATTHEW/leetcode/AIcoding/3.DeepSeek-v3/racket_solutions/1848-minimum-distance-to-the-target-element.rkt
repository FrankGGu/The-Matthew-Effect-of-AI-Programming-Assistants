(define/contract (get-min-distance nums target start)
  (-> (listof exact-integer?) exact-integer? exact-integer? exact-integer?)
  (let loop ([i 0]
             [min-dist (length nums)])
    (cond
      [(= i (length nums)) min-dist]
      [(= (list-ref nums i) target)
       (loop (add1 i) (min min-dist (abs (- i start))))]
      [else (loop (add1 i) min-dist)])))