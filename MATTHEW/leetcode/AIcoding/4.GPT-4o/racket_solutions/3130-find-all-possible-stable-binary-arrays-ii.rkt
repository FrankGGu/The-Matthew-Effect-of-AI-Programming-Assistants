(define (stable-binary-array n)
  (define (is-stable arr)
    (and (not (or (null? arr) (null? (cdr arr))))
         (not (or (and (= (car arr) 1) (equal? (cadr arr) 1))
                  (and (= (car arr) 0) (equal? (cadr arr) 0))))))

  (define (generate-arrays current)
    (if (= (length current) n)
        (if (is-stable current)
            (list current)
            '())
        (append (generate-arrays (append current (list 0)))
                (generate-arrays (append current (list 1))))))

  (generate-arrays '()))

(define (find-all-stable-binary-arrays n)
  (stable-binary-array n))