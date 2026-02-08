(define (combinationSum2 candidates target)
  (define sorted-candidates (sort candidates <))
  (define result '())

  (define (backtrack remaining-target start-index current-path)
    (cond
      [(= remaining-target 0)
       (set! result (cons (reverse current-path) result))]
      [(< remaining-target 0)
       #f] ; Prune if target goes below zero
      [else
       (for ([i (in-range start-index (length sorted-candidates))])
         (define current-candidate (list-ref sorted-candidates i))
         ;; Skip duplicates: if the current candidate is the same as the previous
         ;; one at this level of recursion, skip it to avoid duplicate combinations.
         ;; We only skip if it's not the first element considered at this level (i > start-index).
         (when (or (= i start-index)
                   (!= current-candidate (list-ref sorted-candidates (- i 1))))
           (backtrack (- remaining-target current-candidate)
                      (+ i 1) ; Use each number at most once in a combination
                      (cons current-candidate current-path))))]))

  (backtrack target 0 '())
  result)