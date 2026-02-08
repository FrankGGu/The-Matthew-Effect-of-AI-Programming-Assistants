(define (binary-tree-paths root)
  (define (helper node path acc)
    (cond
      [(null? node) acc]
      [(and (null? (-> node left)) (null? (-> node right)))
       (cons (string-append path (number->string (-> node val))) acc)]
      [else
       (let ((new-path (string-append path (number->string (-> node val)) "->")))
         (append (helper (-> node left) new-path acc)
                 (helper (-> node right) new-path acc)))]))
  (if (null? root)
      '()
      (helper root "" '())))