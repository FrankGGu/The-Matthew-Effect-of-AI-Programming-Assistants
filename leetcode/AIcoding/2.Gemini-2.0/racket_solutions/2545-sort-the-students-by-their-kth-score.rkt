(define (sort-the-students scores k)
  (sort scores (lambda (a b) (> (list-ref a k) (list-ref b k)))))