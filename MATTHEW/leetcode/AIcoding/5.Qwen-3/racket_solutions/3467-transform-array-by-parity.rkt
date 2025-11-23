(define (sort-array-by-parity nums)
  (let ((even '()) (odd '()))
    (for-each
     (lambda (x)
       (if (even? x)
           (set! even (cons x even))
           (set! odd (cons x odd))))
     nums)
    (append (reverse even) (reverse odd))))