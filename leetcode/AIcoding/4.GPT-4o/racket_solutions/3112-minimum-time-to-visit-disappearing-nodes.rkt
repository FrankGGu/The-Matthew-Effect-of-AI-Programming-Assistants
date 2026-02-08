(define (minTimeToVisitNodes edges)
  (define (dfs node visited)
    (if (set-member? visited node)
        0
        (let ((new-visited (set-add visited node)))
          (apply + (map (lambda (neighbor) (+ 1 (dfs neighbor new-visited))) (list-ref edges node))))))
  (dfs 0 (set-empty)))

(define (minTimeToVisit edges)
  (minTimeToVisitNodes edges))