(define (distribute-elements-to-two-arrays nums)
  (define (helper a b nums)
    (cond [(null? nums) (list a b)]
          [else
           (let* ([x (car nums)]
                  [a-sum (+ x (if (even? (length a)) 0 (car a)))]
                  [b-sum (+ x (if (even? (length b)) 0 (car b)))])
             (if (< a-sum b-sum)
                 (helper (cons x a) b (cdr nums))
                 (helper a (cons x b) (cdr nums))))]))
  (let ([result (helper '() '() nums)])
    (list (reverse (car result)) (reverse (cadr result)))))