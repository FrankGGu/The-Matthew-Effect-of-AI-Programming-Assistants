(define (all-ancestors graph node)
  (define (dfs current visited)
    (if (set-member? visited current)
        '()
        (begin
          (define new-visited (set-add visited current))
          (define ancestors (map (lambda (neighbor) (dfs neighbor new-visited))
                                  (hash-ref graph current '())))
          (cons current (apply append ancestors)))))
  (set->list (set (dfs node (set))))
)

(define (findAncestors graph node)
  (all-ancestors graph node))