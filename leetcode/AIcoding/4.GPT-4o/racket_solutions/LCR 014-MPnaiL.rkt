(define (permutations s)
  (define (helper current remaining)
    (if (empty? remaining)
        (list current)
        (apply append
               (map (lambda (c)
                      (helper (string-append current (string c))
                              (remove c remaining)))
                    remaining))))
  (helper "" (string->list s)))

(define (permute s)
  (define unique-perms (remove-duplicates (permutations s)))
  (map (lambda (x) (list->string x)) unique-perms))