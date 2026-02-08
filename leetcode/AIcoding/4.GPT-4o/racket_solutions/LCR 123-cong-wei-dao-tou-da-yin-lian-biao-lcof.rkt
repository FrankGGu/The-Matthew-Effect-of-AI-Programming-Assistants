(define (organizeBooks books)
  (define (helper books acc)
    (if (null? books)
        acc
        (let ((current-book (car books)))
          (if (member current-book acc)
              (helper (cdr books) acc)
              (helper (cdr books) (cons current-book acc))))))
  (helper books '()))

(organizeBooks '(1 2 3 2 1 4))