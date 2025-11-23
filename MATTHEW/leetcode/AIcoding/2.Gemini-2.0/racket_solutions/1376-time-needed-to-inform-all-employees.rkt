(define (num-minutes headID informTime subordinates)
  (letrec ((dfs (lambda (node)
            (if (null? (hash-ref subordinates node #f))
                0
                (apply max (map (lambda (sub) (+ (list-ref informTime node) (dfs sub))) (hash-ref subordinates node #f)))))))
    (dfs headID)))