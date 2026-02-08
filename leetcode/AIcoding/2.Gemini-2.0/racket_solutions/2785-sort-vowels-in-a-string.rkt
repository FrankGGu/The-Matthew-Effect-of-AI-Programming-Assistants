(define (sort-vowels-in-string s)
  (define vowels (string->list (string-downcase s)))
  (define (is-vowel? c)
    (member c '(#\a #\e #\i #\o #\u)))
  (define vowel-chars (filter is-vowel? vowels))
  (define sorted-vowels (sort vowel-chars char<?))
  (define (replace-vowels lst sv)
    (cond [(null? lst) '()]
          [(is-vowel? (car lst)) (cons (car sv) (replace-vowels (cdr lst) (cdr sv)))]
          [else (cons (car lst) (replace-vowels (cdr lst) sv))]))
  (string->list s)
  (define original-list (string->list s))
  (define lowercase-list (string->list (string-downcase s)))
  (define new-list (replace-vowels lowercase-list sorted-vowels))
  (define (restore-case lst orig)
    (cond [(null? lst) '()]
          [else
           (let ((c (car lst)) (o (car orig)))
             (cons (if (char-upper-case? o) (char-upcase c) c) (restore-case (cdr lst) (cdr orig))))]))
  (list->string (restore-case new-list original-list)))