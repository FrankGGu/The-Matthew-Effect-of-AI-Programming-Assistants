(define (serialize root)
  (define (serialize-helper node)
    (cond
      [(null? node) "#"]
      [else (string-append (number->string (car node)) "," (serialize-helper (cadr node)) "," (serialize-helper (caddr node)))]))
  (serialize-helper root))

(define (deserialize data)
  (define data-list (string-split data ","))
  (define index (box 0))

  (define (deserialize-helper)
    (define i (unbox index))
    (define val (list-ref data-list i))
    (set-box! index (+ i 1))

    (cond
      [(equal? val "#") null]
      [else (list (string->number val) (deserialize-helper) (deserialize-helper))]))

  (deserialize-helper))