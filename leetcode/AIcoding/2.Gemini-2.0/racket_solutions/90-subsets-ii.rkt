(define (subsets-with-dup nums)
  (define (helper nums current-subset result)
    (cond
      [(empty? nums) (cons current-subset result)]
      [else
       (let* ([first (car nums)]
              [rest (cdr nums)]
              [without-first (helper rest current-subset result)]
              [with-first (helper rest (cons first current-subset) result)])
         (cons with-first without-first))]))

  (define (remove-duplicates lst)
    (foldr (lambda (x acc)
             (if (member? x acc equal?)
                 acc
                 (cons x acc)))
           '()
           lst))

  (define (sort-subsets lst)
    (map sort lst))

  (remove-duplicates (sort-subsets (helper (sort nums <) '() '()))))