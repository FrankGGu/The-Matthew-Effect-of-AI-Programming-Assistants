(define (combination-sum candidates target)
  (define results '())

  (define (backtrack remaining current-combination start-index)
    (cond
      [(= remaining 0)
       (set! results (cons (reverse current-combination) results))]
      [(< remaining 0)
       ; Do nothing, this path is invalid
       ]
      [else
       (for ([i (in-range start-index (length candidates))])
         (define candidate (list-ref candidates i))
         (backtrack (- remaining candidate) (cons candidate current-combination) i))]))

  (backtrack target '() 0)
  (reverse results))