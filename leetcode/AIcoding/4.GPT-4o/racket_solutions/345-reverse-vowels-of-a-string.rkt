(define (reverse-vowels s)
  (define vowels (string->list "aeiouAEIOU"))
  (define (is-vowel c) (member c vowels))
  (define lst (string->list s))
  (define vowels-list (filter is-vowel lst))
  (define reversed-vowels (reverse vowels-list))
  (define (replace-vowels lst vowels)
    (cond
      [(null? lst) '()]
      [(is-vowel (car lst)) (cons (car reversed-vowels) (replace-vowels (cdr lst) (cdr reversed-vowels)))]
      [else (cons (car lst) (replace-vowels (cdr lst) vowels))]))
  (list->string (replace-vowels lst reversed-vowels)))

(reverse-vowels "hello") ; Example call