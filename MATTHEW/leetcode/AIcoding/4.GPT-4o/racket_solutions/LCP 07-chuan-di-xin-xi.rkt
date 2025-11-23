(define (num-of-ways n relation)
  (define (dfs node visited)
    (if (equal? (length visited) n)
        1
        (apply + (map (lambda (neighbor)
                        (if (not (member neighbor visited))
                            (dfs neighbor (cons neighbor visited))
                            0))
                      (cdr (assoc node relation))))))
  (dfs 0 '(0)))

(define (numWays n relation)
  (num-of-ways n relation))