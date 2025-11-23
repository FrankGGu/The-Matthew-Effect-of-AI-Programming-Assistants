(define (max-element-after-merge nums)
  (define (merge lst)
    (cond [(null? lst) '()]
          [(null? (cdr lst)) lst]
          [else
           (let ([a (car lst)]
                 [b (cadr lst)])
             (if (< a b)
                 (cons (+ a b) (merge (cddr lst)))
                 (cons (+ a b) (merge (cddr lst)))))]))
  (let loop ([nums nums])
    (if (= (length nums) 1)
        (car nums)
        (loop (merge nums)))))