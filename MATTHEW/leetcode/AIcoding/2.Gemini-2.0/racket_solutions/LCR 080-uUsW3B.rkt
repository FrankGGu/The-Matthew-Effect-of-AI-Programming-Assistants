(define (combine n k)
  (define (helper start current-combination)
    (cond
      [(= (length current-combination) k) (list current-combination)]
      [(= start (+ n 1)) '()]
      [else (append (helper (+ start 1) (append current-combination (list start)))
                    (helper (+ start 1) current-combination))]))
  (helper 1 '()))