(define (sum-of-left-leaves root)
  (cond
    [(null? root) 0]
    [(and (not (null? (car root))) (null? (car (car root))) (null? (cdr (car root))))) (car (car root))]
    [else (+ (sum-of-left-leaves (car root)) (sum-of-left-leaves (cdr root)))]))