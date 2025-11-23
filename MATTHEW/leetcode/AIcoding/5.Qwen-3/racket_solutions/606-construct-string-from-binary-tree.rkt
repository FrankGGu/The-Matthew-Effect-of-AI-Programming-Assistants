(define (tree-to-string root)
  (if (null? root)
      ""
      (let ((val (car root))
            (left (cadr root))
            (right (caddr root)))
        (string-append (number->string val)
                       (if (and (null? left) (null? right))
                           ""
                           (string-append "(" (tree-to-string left) ")"))
                       (if (null? right)
                           ""
                           (string-append "(" (tree-to-string right) ")"))))))