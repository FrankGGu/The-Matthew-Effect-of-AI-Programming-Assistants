(define (delete-book books)
  (if (null? books)
      '()
      (cdr books)))

(define (add-book books book)
  (cons book books))

(define (peek-book books)
  (if (null? books)
      -1
      (car books)))

(define (empty? books)
  (null? books))