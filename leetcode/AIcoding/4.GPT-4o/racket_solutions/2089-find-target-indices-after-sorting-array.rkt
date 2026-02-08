(define (target-indices nums target)
  (define sorted-nums (sort nums <))
  (define (find-target-indices lst idx)
    (cond
      [(null? lst) '()]
      [(= (car lst) target) (cons idx (find-target-indices (cdr lst) (+ idx 1)))]
      [else (find-target-indices (cdr lst) (+ idx 1))]))
  (find-target-indices sorted-nums 0))