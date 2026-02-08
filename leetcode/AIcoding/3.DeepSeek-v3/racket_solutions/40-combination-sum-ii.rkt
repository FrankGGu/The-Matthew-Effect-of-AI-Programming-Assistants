(define/contract (combination-sum2 candidates target)
  (-> (listof exact-integer?) exact-integer? (listof (listof exact-integer?)))
  (let ([result '()]
        [path '()])
    (define (backtrack start target)
      (cond
        [(= target 0) (set! result (cons (reverse path) result))]
        [(< target 0) #f]
        [else
         (for ([i (in-range start (length candidates))])
           (when (or (= i start) (not (= (list-ref candidates i) (list-ref candidates (sub1 i)))))
             (let ([num (list-ref candidates i)])
               (set! path (cons num path))
               (backtrack (add1 i) (- target num))
               (set! path (cdr path)))))]))

    (set! candidates (sort candidates <))
    (backtrack 0 target)
    result))