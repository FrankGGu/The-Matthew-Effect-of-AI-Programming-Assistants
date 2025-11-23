(define (combination-sum2 candidates target)
  (define (helper current-sum current-combination remaining-candidates start-index)
    (cond
      [(> current-sum target) '()]
      [(= current-sum target) (list current-combination)]
      [else
       (let loop ([i start-index] [results '()])
         (cond
           [(>= i (length remaining-candidates)) results]
           [else
            (let* ([candidate (list-ref remaining-candidates i)]
                   [new-sum (+ current-sum candidate)]
                   [new-combination (append current-combination (list candidate))]
                   [new-results (helper new-sum new-combination remaining-candidates (+ i 1))])
              (let ([next-i (let next-loop ([j (+ i 1)])
                                (cond
                                  [(>= j (length remaining-candidates)) (length remaining-candidates)]
                                  [(= (list-ref remaining-candidates j) candidate) (+ j 1)]
                                  [else j])))])
              (loop next-i (append results new-results))))]))]))

  (let ([sorted-candidates (sort candidates <)])
    (remove-duplicates (helper 0 '() sorted-candidates 0) equal?)))