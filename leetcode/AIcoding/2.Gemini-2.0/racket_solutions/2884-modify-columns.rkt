(define (modify-columns df modifiers)
  (for/list ([modifier (in-list modifiers)])
    (match modifier
      [(list 'drop col)
       (hash-remove df col)]
      [(list 'rename col new-name)
       (let ([val (hash-ref df col #f)])
         (if val
             (hash-set (hash-remove df col) new-name val)
             df))]
      [(list 'cast col new-type)
       (hash-update df col
                    (λ (val)
                      (cond
                        [(equal? new-type 'int) (exact->inexact val)]
                        [(equal? new-type 'string) (number->string val)]
                        [else val]))
                    #f)]
      [_ df])))