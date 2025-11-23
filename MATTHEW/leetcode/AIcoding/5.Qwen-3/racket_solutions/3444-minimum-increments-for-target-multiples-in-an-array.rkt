(define (min-increments nums target)
  (define (helper nums target count)
    (cond [(null? nums) count]
          [(= (car nums) target) (helper (cdr nums) target count)]
          [(< (car nums) target) (helper (cdr nums) target (+ count (- target (car nums))))]
          [else (helper (cdr nums) target count)]))
  (helper nums target 0))