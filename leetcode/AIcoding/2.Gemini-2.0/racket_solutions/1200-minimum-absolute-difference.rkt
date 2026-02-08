(define (minimum-abs-difference arr)
  (define sorted-arr (sort arr <))
  (define (min-diff lst min-so-far)
    (cond
      [(null? (cdr lst)) min-so-far]
      [else (min-diff (cdr lst) (min min-so-far (abs (- (car (cdr lst)) (car lst)))))]))
  (min-diff sorted-arr +inf.0))