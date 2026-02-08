(define (checkPossibility nums)
  (define (helper nums modified)
    (if (or (null? nums) (null? (cdr nums))) #t
        (let ((a (car nums))
              (b (cadr nums)))
          (if (<= a b)
              (helper (cdr nums) modified)
              (if modified
                  #f
                  (or (helper (cons a (cddr nums)) #t)
                      (helper (cons b (cddr nums)) #t))))))
    )
  (helper nums #f))

(checkPossibility '(4 2 3))