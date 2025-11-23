(define (numMinutesToInformAllEmployees n headID manager informTime)
  (define (dfs id)
    (let loop ([subordinates (filter (lambda (i) (= (list-ref manager i) id)) (range n))])
               [total-time 0])
      (if (null? subordinates)
          total-time
          (for/sum ([sub subordinate subordinates])
            (+ (dfs sub) (list-ref informTime id))))))

  (dfs headID))

(numMinutesToInformAllEmployees n headID manager informTime)