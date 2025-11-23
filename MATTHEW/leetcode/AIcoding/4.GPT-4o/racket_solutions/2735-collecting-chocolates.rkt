(define (max-chocolates chocolates k)
  (define (collect choco)
    (foldl (lambda (x acc)
             (if (and (<= (car x) k) (<= (cadr x) k))
                 (+ acc (cadr x))
                 acc))
           0
           choco))
  (collect chocolates))