(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (modulo a b))))

(define (gcdTraversal nums)
  (define (dfs index visited)
    (if (in-set? visited index)
        '()
        (let ((new-visited (set-add visited index)))
          (cons (list-ref nums index)
                (apply append
                       (map (lambda (i)
                              (if (and (not (in-set? visited i))
                                       (= (gcd (list-ref nums index) (list-ref nums i)) 1))
                                  (dfs i new-visited)
                                  '()))
                            (range (length nums))))))))
  (dfs 0 (set-empty)))

(define (gcdTraversalMain nums)
  (gcdTraversal nums))