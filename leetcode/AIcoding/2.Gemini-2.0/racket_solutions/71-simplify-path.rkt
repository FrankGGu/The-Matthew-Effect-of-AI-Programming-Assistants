(define (simplify-path path)
  (define components (string-split path "/"))
  (define stack '())
  (for-each
   (lambda (component)
     (cond
       ((or (equal? component "") (equal? component ".")))
       ((equal? component "..") (if (not (null? stack)) (set! stack (cdr stack))))
       (else (set! stack (cons component stack)))))
   components)
  (list->string
   (append (list "/")
           (reverse (apply append (map (lambda (x) (list x "/")) (reverse stack))))
           (if (null? stack) '() (list (string-drop-right (car (last stack)) 1))))))