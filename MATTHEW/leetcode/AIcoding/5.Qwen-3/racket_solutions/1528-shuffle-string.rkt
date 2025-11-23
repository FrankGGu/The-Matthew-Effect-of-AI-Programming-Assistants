(define (shuffle-string s indices)
  (list->string
   (map (lambda (i) (string-ref s i))
        (sort (map (lambda (i) (cons i (string-ref s i))) (string->list indices))
              (lambda (a b) (< (car a) (car b)))))))