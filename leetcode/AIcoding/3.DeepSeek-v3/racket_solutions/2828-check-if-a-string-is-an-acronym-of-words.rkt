(define (is-acronym words s)
  (let loop ([words words] [s s] [i 0])
    (cond
      [(and (null? words) (null? s)) #t]
      [(or (null? words) (null? s)) #f]
      [(not (char=? (string-ref (car words) 0) (string-ref s i))) #f]
      [else (loop (cdr words) s (add1 i))])))