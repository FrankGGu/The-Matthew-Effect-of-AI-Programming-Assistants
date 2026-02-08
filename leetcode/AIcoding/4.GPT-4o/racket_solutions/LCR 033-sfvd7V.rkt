(define (group-anagrams strs)
  (define (sort-string s)
    (string->list s)
    (sort (lambda (a b) (< (char->integer a) (char->integer b))) s)
    (list->string s))

  (define anagrams (make-hash))

  (for-each (lambda (s)
              (define sorted (sort-string s))
              (hash-set! anagrams sorted (cons s (hash-ref anagrams sorted '()))))
            strs)

  (hash->list (map (lambda (lst) (reverse lst)) anagrams)))