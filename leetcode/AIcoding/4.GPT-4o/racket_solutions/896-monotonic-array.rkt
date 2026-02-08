(define (isMonotonic A)
  (define (increasing? lst)
    (for/list ([i (in-range 1 (length lst))])
      (if (<= (list-ref lst (- i 1)) (list-ref lst i)) #t #f)))

  (define (decreasing? lst)
    (for/list ([i (in-range 1 (length lst))])
      (if (>= (list-ref lst (- i 1)) (list-ref lst i)) #t #f)))

  (or (increasing? A) (decreasing? A))
)