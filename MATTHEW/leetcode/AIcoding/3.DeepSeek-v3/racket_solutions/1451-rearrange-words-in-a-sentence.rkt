(define (arrange-words text)
  (let* ([words (string-split (string-downcase text))]
         [sorted-words (sort words (lambda (a b) (< (string-length a) (string-length b))))]
         [result (string-join sorted-words " ")])
    (string-titlecase result)))