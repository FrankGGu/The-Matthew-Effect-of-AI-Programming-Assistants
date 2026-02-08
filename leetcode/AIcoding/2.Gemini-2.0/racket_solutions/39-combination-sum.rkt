(define (combination-sum candidates target)
  (define (helper candidates target current-combination)
    (cond
      [(zero? target) (list (reverse current-combination))]
      [(negative? target) '()]
      [else
       (foldr
        (lambda (candidate acc)
          (append (helper candidates (- target candidate) (cons candidate current-combination)) acc))
        '()
        candidates)]))
  (remove-duplicates (helper candidates target '()) equal?))