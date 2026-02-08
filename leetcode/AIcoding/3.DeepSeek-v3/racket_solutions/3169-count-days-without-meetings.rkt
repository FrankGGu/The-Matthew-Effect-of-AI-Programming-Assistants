(define/contract (count-days days meetings)
  (-> exact-integer? (listof (listof exact-integer?)) exact-integer?)
  (define meeting-days (mutable-set))
  (for ([meeting meetings])
    (let ([start (first meeting)]
          [end (second meeting)])
      (for ([day (in-range start (add1 end))])
        (set-add! meeting-days day))))
  (- days (set-count meeting-days)))