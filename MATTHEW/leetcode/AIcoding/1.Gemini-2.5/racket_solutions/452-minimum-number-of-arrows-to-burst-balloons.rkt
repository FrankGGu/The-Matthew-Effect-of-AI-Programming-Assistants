(define (find-min-arrows-to-burst-balloons points)
  (if (empty? points)
      0
      (let* ([sorted-points (sort points (lambda (p1 p2)
                                           (< (second p1) (second p2))))]
             [initial-state (list 0 -inf.0)])
        (let-values ([(arrows current-arrow-limit)
                      (foldl (lambda (balloon state)
                               (let* ([start (first balloon)]
                                      [end (second balloon)]
                                      [current-arrows (first state)]
                                      [current-limit (second state)])
                                 (if (> start current-limit)
                                     (list (add1 current-arrows) end)
                                     state)))
                             initial-state
                             sorted-points)])
          arrows))))