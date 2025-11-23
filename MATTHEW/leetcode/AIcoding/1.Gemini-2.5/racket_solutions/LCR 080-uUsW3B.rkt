(define (combine n k)
  (define (backtrack current-combo start-num k-remaining)
    (cond
      ((zero? k-remaining)
       (list (reverse current-combo)))
      ((> start-num (+ n (- k-remaining 1)))
       '())
      (else
       (apply append
              (for/list ([i (in-range start-num (+ n (- k-remaining 1) 2))])
                (backtrack (cons i current-combo) (+ i 1) (- k-remaining 1)))))))

  (backtrack '() 1 k))