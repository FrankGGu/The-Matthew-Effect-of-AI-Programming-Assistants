(define (faulty-keyboard s)
  (string-foldl
   (lambda (c acc)
     (if (equal? c #\i)
         (string-reverse acc)
         (string-append acc (string c))))
   ""
   s))