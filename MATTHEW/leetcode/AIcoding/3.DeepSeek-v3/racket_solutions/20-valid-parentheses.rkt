(define/contract (is-valid s)
  (-> string? boolean?)
  (let ([stack '()]
        [pairs (hash #\) #\( #\] #\[ #\} #\{)])
    (for ([char (in-string s)])
      (cond
        [(hash-has-key? pairs char)
         (if (or (null? stack) (not (equal? (hash-ref pairs char) (car stack))))
             (set! stack #f)
             (set! stack (cdr stack)))]
        [else (set! stack (cons char stack))]))
    (and (list? stack) (null? stack))))