(define (permute nums)
  (cond [(null? nums) '()]
        [(null? (cdr nums)) (list nums)]
        [else
         (for/fold ([result '()])
                   ([i (in-range (length nums))])
           (append result
                   (map (lambda (p)
                          (append (take nums i)
                                  (list (list-ref nums i))
                                  p))
                        (permute (append (take nums i)
                                         (drop nums (add1 i)))))))]))