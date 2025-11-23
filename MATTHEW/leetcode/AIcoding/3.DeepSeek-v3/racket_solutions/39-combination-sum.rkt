(define/contract (combination-sum candidates target)
  (-> (listof exact-integer?) exact-integer? (listof (listof exact-integer?)))
  (let loop ([start 0] [remaining target] [path '()] [result '()])
    (cond
      [(= remaining 0) (cons (reverse path) result)]
      [(< remaining 0) result]
      [else
       (for/fold ([res result])
                 ([i (in-range start (length candidates))])
         (loop i
               (- remaining (list-ref candidates i))
               (cons (list-ref candidates i) path)
               res))])))