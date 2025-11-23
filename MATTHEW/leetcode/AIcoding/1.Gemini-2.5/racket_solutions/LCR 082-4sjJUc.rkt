(define (combination-sum2 candidates target)
  (define result-list '())
  (define sorted-candidates (sort candidates <))
  (define n (length sorted-candidates))

  (define (backtrack current-combination-rev remaining-target start-index)
    (cond
      [(= remaining-target 0)
       (set! result-list (cons (reverse current-combination-rev) result-list))]
      [(< remaining-target 0)
       #f]
      [else
       (for ([i (in-range start-index n)])
         (let ([current-num (list-ref sorted-candidates i)])
           (when (or (= i start-index) (not (= current-num (list-ref sorted-candidates (- i 1)))))
             (backtrack (cons current-num current-combination-rev)
                        (- remaining-target current-num)
                        (+ i 1)))))]))

  (backtrack '() target 0)
  result-list)