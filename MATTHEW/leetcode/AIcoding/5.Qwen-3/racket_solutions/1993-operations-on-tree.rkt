(define (count-operations-to-make-array-empty nums)
  (define (helper nums)
    (cond [(null? nums) 0]
          [else
           (let loop ([nums nums] [count 0])
             (if (null? nums)
                 count
                 (loop (filter (lambda (x) (not (= x (car nums)))) (cdr nums)) (+ count 1))))]))
  (helper nums))