(define (find-no-available-copies books)
  (filter (lambda (book) (= (cdr (assv 'available-copies book)) 0)) books))