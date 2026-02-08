(define (sort-vowels s)
  (define (is-vowel? c)
    (member c '(#\a #\e #\i #\o #\u #\A #\E #\I #\O #\U)))

  (define char-list (string->list s))
  (define vowels-only (filter is-vowel? char-list))
  (define sorted-vowels (sort vowels-only char<?))

  (define vowel-idx 0)

  (define result-chars
    (for/list ([c char-list])
      (if (is-vowel? c)
          (begin
            (set! vowel-idx (+ vowel-idx 1))
            (list-ref sorted-vowels (- vowel-idx 1)))
          c)))

  (list->string result-chars))