(define (path-encryption path)
  (list->string
   (for/list ([c (string->list path)])
     (if (char=? c #\.) #\space c))))