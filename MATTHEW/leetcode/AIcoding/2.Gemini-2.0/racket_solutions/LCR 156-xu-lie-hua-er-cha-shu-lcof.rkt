(define (serialize root)
  (define (serialize-helper node)
    (cond
      [(null? node) "#,"]
      [else (string-append (number->string (car node)) ","
                           (serialize-helper (cadr node))
                           (serialize-helper (caddr node)))]))
  (serialize-helper root))

(define (deserialize data)
  (define (deserialize-helper lst)
    (cond
      [(equal? (car lst) "#") (cons null (cdr lst))]
      [else
       (let* ([node-val (string->number (car lst))]
              [left-result (deserialize-helper (cdr lst))]
              [left-node (car left-result)]
              [right-result (deserialize-helper (cdr left-result))]
              [right-node (car right-result)]
              [remaining-list (cdr right-result)])
         (cons (list node-val left-node right-node) remaining-list))]))
  (car (deserialize-helper (string-split data ","))))