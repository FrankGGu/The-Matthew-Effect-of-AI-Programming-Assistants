(define (combination-sum3 k n)
  (define (backtrack start current sum)
    (cond [(= (length current) k) (if (= sum n) (list current) '())]
          [(> sum n) '()]
          [else
           (append
            (for/list ([i (in-range start 10)])
              (append current (list i)))
            (for*/list ([i (in-range start 10)]
                        [sub (backtrack (+ i 1) (append current (list i)) (+ sum i))])
              sub))]))
  (backtrack 1 '() 0))