(define (permute nums)
  (cond [(null? nums) '()]
        [(null? (cdr nums)) (list (list (car nums)))]
        [else
         (let loop ([n (car nums)] [rest (cdr nums)] [result '()])
           (if (null? rest)
               result
               (loop n (cdr rest) (append (map (lambda (p) (cons n p)) (permute (cdr rest))) result))))]))