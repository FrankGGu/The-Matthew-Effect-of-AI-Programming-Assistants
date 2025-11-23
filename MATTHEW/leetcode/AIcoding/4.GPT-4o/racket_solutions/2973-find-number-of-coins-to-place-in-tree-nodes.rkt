(define (min-coins nodes)
  (define (dfs node)
    (if (null? node)
        '()
        (let* ((left (dfs (car node)))
               (right (dfs (cadr node)))
               (total (+ (car node) (car left) (car right))))
          (list total (+ (cadr left) (cadr right) (if (< total 1) 1 0))))))
  (cadr (dfs nodes)))

(define (minCoins root)
  (if (null? root)
      0
      (min-coins root)))