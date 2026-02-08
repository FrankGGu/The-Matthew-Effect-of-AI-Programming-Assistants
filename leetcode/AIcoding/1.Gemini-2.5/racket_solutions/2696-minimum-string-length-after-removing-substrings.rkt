(define (minimum-string-length s)
  (define chars (string->list s))
  (define final-stack
    (foldl
     (lambda (char current-stack)
       (if (and (not (empty? current-stack))
                (let ((top (car current-stack)))
                  (or (and (char=? top #\A) (char=? char #\B))
                      (and (char=? top #\C) (char=? char #\D)))))
           (cdr current-stack)
           (cons char current-stack)))
     '()
     chars))
  (length final-stack))