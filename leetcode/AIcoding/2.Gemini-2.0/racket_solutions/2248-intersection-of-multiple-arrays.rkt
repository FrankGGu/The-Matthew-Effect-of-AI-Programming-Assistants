(define (intersection nums)
  (cond
    [(null? nums) '()]
    [else
     (let loop ([sets nums] [result (car nums)])
       (cond
         [(null? sets) result]
         [else
          (let ([current-set (car sets)])
            (let ([new-result (list)])
              (for ([x (in-list result)])
                (when (member x current-set)
                  (set! new-result (append new-result (list x)))))
              (loop (cdr sets) new-result))))]))))

(define (intersection-multiple-arrays nums)
  (sort (intersection nums) <))