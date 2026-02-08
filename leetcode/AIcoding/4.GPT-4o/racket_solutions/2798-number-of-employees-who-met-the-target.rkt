(define (numberOfEmployeesWhoMetTarget hours target)
  (length (filter (lambda (x) (>= x target)) hours)))