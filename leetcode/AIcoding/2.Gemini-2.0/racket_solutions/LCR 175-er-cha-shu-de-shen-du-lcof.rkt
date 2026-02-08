(define (max a b)
  (if (> a b) a b))

(define (max-depth root)
  (cond
    [(null? root) 0]
    [else (+ 1 (max (max-depth (car root)) (max-depth (cdr root))))]))