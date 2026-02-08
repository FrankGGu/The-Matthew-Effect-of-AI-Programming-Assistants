(define (subsets nums)
  (define (helper subset nums)
    (if (null? nums)
        (list subset)
        (append (helper (cons (car nums) subset) (cdr nums))
                (helper subset (cdr nums)))))
  (helper '() nums))

(subsets '(1 2 3))