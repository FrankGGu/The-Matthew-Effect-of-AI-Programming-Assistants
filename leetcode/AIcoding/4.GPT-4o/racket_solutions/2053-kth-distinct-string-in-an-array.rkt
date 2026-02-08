(define (distinct-string-at-index arr k)
  (define (distinct-strings lst)
    (define (helper lst seen)
      (cond
        [(null? lst) '()]
        [(member (car lst) seen) (helper (cdr lst) seen)]
        [else (cons (car lst) (helper (cdr lst) (cons (car lst) seen)))]))
    (helper lst '()))
  (define distincts (distinct-strings arr))
  (if (and (>= k 1) (<= k (length distincts)))
      (list-ref distincts (sub1 k))
      ""))