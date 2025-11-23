(define (can-reach destination start fuel)
  (define (dfs pos fuel)
    (if (>= pos destination) #t
        (foldl (lambda (next acc)
                  (if acc acc
                      (let ((needed-fuel (- next pos)))
                        (if (and (>= fuel needed-fuel) (dfs next (- fuel needed-fuel)))
                            #t
                            #f))))
                #f
                (filter (lambda (x) (> x pos)) locations)))
  (dfs start fuel))

(define (can-reach-solution locations start fuel destination)
  (can-reach destination start fuel))