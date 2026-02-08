(define (highAccessEmployees employees threshold)
  (filter (lambda (emp) (>= (cdr emp) threshold)) employees))