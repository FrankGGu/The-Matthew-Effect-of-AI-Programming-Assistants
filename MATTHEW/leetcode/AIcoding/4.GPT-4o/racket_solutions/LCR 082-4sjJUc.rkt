(define (combination-sum2 candidates target)
  (define (backtrack start target path results)
    (cond
      [(= target 0) (set! results (cons (list->vector path) results))]
      [(< target 0) '()]
      [else
       (for* ([i (in-range start (length candidates))])
         (when (or (= i start) (not (= (vector-ref candidates i) (vector-ref candidates (- i 1)))))
           (set! path (cons (vector-ref candidates i) path))
           (backtrack (+ i 1) (- target (vector-ref candidates i)) path results)
           (set! path (cdr path)))]))
    results)

  (define sorted (vector->list (sort (vector->list candidates) <)))
  (define results '())
  (backtrack 0 target '() results)
  (remove-duplicates results))

(define (combination-sum2-main candidates target)
  (combination-sum2 (vector->list (vector candidates)) target))