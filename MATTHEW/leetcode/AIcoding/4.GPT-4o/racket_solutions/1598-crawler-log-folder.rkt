(define (minOperations logs)
  (define (helper logs)
    (foldl (lambda (log acc)
              (cond
                [(equal? log "../") (if (> acc 0) (sub1 acc) acc)]
                [(equal? log "./") acc]
                [else (add1 acc)]))
            0
            logs))
  (helper logs))