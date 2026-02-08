(define (remove-methods project methods)
  (define methods-set (set methods))
  (define (process-class class)
    (cond
      [(hash? class)
       (hash-map class
                 (lambda (k v)
                   (cond
                     [(equal? k 'methods)
                      (filter (lambda (method)
                                (not (set-member? methods-set method)))
                              v)]
                     [else v])))]
      [(list? class)
       (map process-class class)]
      [else
       class]))
  (process-class project))