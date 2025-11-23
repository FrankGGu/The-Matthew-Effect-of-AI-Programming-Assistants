(define (to-lower-case s)
  (list->string (map (lambda (c)
                       (if (and (char>=? c #\A) (char<=? c #\Z))
                           (integer->char (+ (char->integer c) 32))
                           c))
                     (string->list s)))）