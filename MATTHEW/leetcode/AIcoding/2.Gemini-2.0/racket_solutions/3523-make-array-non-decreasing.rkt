(define (make-array-non-decreasing nums)
  (let loop ([nums nums] [stack '()])
    (cond
      [(empty? nums)
       (length stack)]
      [else
       (let ([curr (car nums)] [rest (cdr nums)])
         (cond
           [(empty? stack)
            (loop rest (cons curr stack))]
           [(>= curr (car stack))
            (loop rest (cons curr stack))]
           [else
            (let loop2 ([stack stack] [count 0])
              (cond
                [(empty? stack)
                 (loop rest (cons curr stack))]
                [(>= curr (car stack))
                 (loop rest (cons curr stack))]
                [else
                 (loop2 (cdr stack) (+ count 1))]))]))])))