(define (min-add-to-make-valid s)
  (define (helper s)
    (foldl (lambda (char acc)
             (cond
               [(equal? char #\() (cons (add1 (car acc)) (cdr acc))]
               [(equal? char #\)) 
                (if (> (car acc) 0)
                    (cons (sub1 (car acc)) (cdr acc))
                    (cons (car acc) (add1 (cdr acc))))]
               [else acc]))
           (list 0 0)
           s))
  (apply + (helper s)))