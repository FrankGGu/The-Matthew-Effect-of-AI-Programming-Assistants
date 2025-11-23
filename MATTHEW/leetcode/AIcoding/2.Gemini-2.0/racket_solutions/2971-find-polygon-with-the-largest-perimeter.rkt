(define (largestPerimeter nums)
  (sort! nums >)
  (let loop ([nums nums] [sum 0])
    (cond
      [(null? nums) -1]
      [(null? (cdr nums)) -1]
      [(null? (cddr nums)) -1]
      [else
       (let ([a (car nums)] [b (cadr nums)] [c (caddr nums)])
         (if (> a (+ b c))
             (loop (cdr nums) sum)
             (+ a b c)))])))