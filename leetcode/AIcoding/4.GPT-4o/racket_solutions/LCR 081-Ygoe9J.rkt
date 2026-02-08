(define (combination-sum candidates target)
  (define (backtrack start path target)
    (cond
      [(= target 0) (list path)]
      [(< target 0) '()]
      [else
       (for/fold ([result '()]) ([i (in-range start (length candidates))])
         (append result (backtrack i (cons (list-ref candidates i) path) (- target (list-ref candidates i)))))]))
  (reverse (backtrack 0 '() target)))

(combination-sum '(2 3 6 7) 7)