(define (serialize root)
  (define (serialize-helper node)
    (cond [(null? node) "null,"]
          [else (string-append (number->string (car node)) ","
                               (serialize-helper (cadr node))
                               (serialize-helper (caddr node)))]))
  (if (null? root) "" (serialize-helper root)))

(define (deserialize data)
  (define (deserialize-helper lst)
    (cond [(empty? lst) (values null lst)]
          [(equal? (car lst) "null") (values null (cdr lst))]
          [else
           (define root-val (string->number (car lst)))
           (define (deserialize-left-and-right lst)
             (define-values (left-node remaining-lst-after-left) (deserialize-helper (cdr lst)))
             (define-values (right-node remaining-lst-after-right) (deserialize-helper remaining-lst-after-left))
             (values left-node right-node remaining-lst-after-right))
           (define-values (left-node right-node remaining-lst) (deserialize-left-and-right lst))
           (values (list root-val left-node right-node) remaining-lst)]))

  (if (string=? data "") null
      (let* ([lst (string-split data ",")]
             [result (deserialize-helper lst)])
        (car result))))