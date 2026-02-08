(define (longest-unequal-adjacent-groups-subsequence words groups)
  (define n (length words))
  (define (solve idx prev-group)
    (cond
      [(>= idx n) '()]
      [(equal? prev-group (list-ref groups idx)) (solve (+ idx 1) prev-group)]
      [else (let ([include (cons (list-ref words idx) (solve (+ idx 1) (list-ref groups idx)))]
                   [exclude (solve (+ idx 1) prev-group)])
               (if (> (length include) (length exclude))
                   include
                   exclude))]))
  (solve 0 #f))