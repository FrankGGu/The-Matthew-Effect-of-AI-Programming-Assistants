(define (calculate "operations")
  (define result 0)
  (for-each (lambda (op)
              (cond 
                [(equal? (car op) "add") (set! result (+ result (cadr op)))]
                [(equal? (car op) "subtract") (set! result (- result (cadr op)))]
                [(equal? (car op) "multiply") (set! result (* result (cadr op)))]
                [(equal? (car op) "divide") (set! result (quotient result (cadr op)))]))
            operations)
  result)