(define (is-non-decreasing lst)
  (cond
    [(or (empty? lst) (empty? (rest lst))) #t]
    [else (and (<= (first lst) (first (rest lst)))
               (is-non-decreasing (rest lst)))]))

(define (is-non-increasing lst)
  (cond
    [(or (empty? lst) (empty? (rest lst))) #t]
    [else (and (>= (first lst) (first (rest lst)))
               (is-non-increasing (rest lst)))]))

(define (is-monotonic nums)
  (or (is-non-decreasing nums)
      (is-non-increasing nums)))