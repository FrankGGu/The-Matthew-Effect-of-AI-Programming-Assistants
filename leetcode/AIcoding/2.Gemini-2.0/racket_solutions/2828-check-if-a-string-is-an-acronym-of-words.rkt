(define (is-acronym s words)
  (define (helper s words idx)
    (cond
      [(and (null? s) (null? words)) #t]
      [(or (null? s) (null? words)) #f]
      [else
       (string=? (substring s 0 1) (substring (car words) 0 1))
       (helper (substring s 1) (cdr words) (+ idx 1))]))
  (if (and (null? s) (null? words))
      #t
      (helper s words 0)))