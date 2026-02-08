(define (restore-string s indices)
  (list->string
   (list-sort
    (lambda (x y) (< (car x) (car y)))
    (map (lambda (i c) (list i c)) indices (string->list s)))))