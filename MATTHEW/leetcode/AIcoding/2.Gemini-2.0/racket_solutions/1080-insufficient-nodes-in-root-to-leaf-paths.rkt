(define (sufficientSubset root limit)
  (define (helper node sum)
    (cond
      [(null? node) #f]
      [(and (null? (cdr node)) (null? (car node))) (>= (+ sum (car node)) limit)]
      [else
       (let* ([left-sufficient (helper (car node) (+ sum (car node)) limit)]
              [right-sufficient (helper (cdr node) (+ sum (car node)) limit)])
         (cond
           [(not left-sufficient) (set-car! node null?)]
           [else #f])
         (cond
           [(not right-sufficient) (set-cdr! node null?)]
           [else #f])
         (or left-sufficient right-sufficient))]))

  (if (helper root 0 limit)
      root
      null?))