(define (min-number-game nums)
  (let ([sorted-nums (sort nums <)])
    (define (process-pairs lst)
      (if (null? lst)
          '()
          (let ([a (car lst)]
                [b (cadr lst)])
            (append (list b a) (process-pairs (cddr lst))))))
    (process-pairs sorted-nums)))