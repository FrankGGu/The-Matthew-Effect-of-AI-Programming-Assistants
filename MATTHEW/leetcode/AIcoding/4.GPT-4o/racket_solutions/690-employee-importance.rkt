(struct employee (id importance subordinates))

(define (getImportance employees id)
  (define employee-map (foldl (lambda (e acc) (hash-set acc (employee-id e) e)) (hash) employees))
  (define (dfs emp-id)
    (define emp (hash-ref employee-map emp-id))
    (+ (employee-importance emp)
       (foldl (lambda (acc sub-id) (+ acc (dfs sub-id))) 0 (employee-subordinates emp))))
  (dfs id))