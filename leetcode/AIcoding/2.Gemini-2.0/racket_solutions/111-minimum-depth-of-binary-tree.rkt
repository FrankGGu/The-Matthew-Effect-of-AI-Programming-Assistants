(define (min-depth root)
  (cond
    [(null? root) 0]
    [(and (null? (car root)) (null? (cdr root))) 1]
    [(null? (car root)) (+ 1 (min-depth (cdr root)))]
    [(null? (cdr root)) (+ 1 (min-depth (car root)))]
    [else (+ 1 (min (min-depth (car root)) (min-depth (cdr root))))]))