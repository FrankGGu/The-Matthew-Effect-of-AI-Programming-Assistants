(define (minCostToChangeFinalValue expression target)
  (define (evaluate expr)
    (cond
      ((equal? expr "0") 0)
      ((equal? expr "1") 1)
      (else (error "Invalid expression"))))

  (define (parse expr)
    (cond
      ((string? expr) (evaluate expr))
      ((list? expr) (apply (car expr) (map parse (cdr expr))))
      (else (error "Invalid expression"))))

  (define (cost expr target)
    (if (equal? (parse expr) target)
        0
        (if (equal? target 1)
            1
            (if (equal? target 0)
                1
                (error "Invalid target")))))

  (cost expression target))