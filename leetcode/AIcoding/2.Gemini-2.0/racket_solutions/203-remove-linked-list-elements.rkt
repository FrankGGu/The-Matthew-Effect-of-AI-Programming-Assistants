(define (remove-elements head val)
  (cond
    [(null? head) null]
    [(= (car head) val) (remove-elements (cdr head) val)]
    [else (cons (car head) (remove-elements (cdr head) val))]))