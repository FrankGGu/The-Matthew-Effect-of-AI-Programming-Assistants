(define (min-travel-time nums)
  (define (merge lst)
    (cond [(null? lst) '()]
          [(null? (cdr lst)) lst]
          [else
           (let ([a (car lst)]
                 [b (cadr lst)])
             (if (= a b)
                 (cons (+ a a) (merge (cddr lst)))
                 (cons a (merge (cdr lst)))))]))
  (let loop ([nums nums])
    (if (= (length nums) 1)
        (car nums)
        (loop (merge nums)))))