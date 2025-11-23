(define (sortStudents students k)
  (sort students (lambda (a b) (< (list-ref a k) (list-ref b k)))))