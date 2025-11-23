(define (maximum-element-after-decreasing-and-rearranging arr)
  (define (helper lst prev)
    (cond [(null? lst) prev]
          [else
           (let ([current (car lst)])
             (if (<= current prev)
                 (helper (cdr lst) prev)
                 (helper (cdr lst) current)))]))
  (helper (sort arr <) 0))