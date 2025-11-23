(define/contract (reverse-vowels s)
  (-> string? string?)
  (define vowels (list #\a #\e #\i #\o #\u #\A #\E #\I #\O #\U))
  (define lst (string->list s))
  (define vowel-indices
    (for/list ([i (in-range (length lst))]
               [c (in-list lst)]
               #:when (member c vowels))
      i))
  (define reversed-vowels (reverse (map (lambda (i) (list-ref lst i)) vowel-indices)))
  (for ([i (in-list vowel-indices)]
        [v (in-list reversed-vowels)])
    (list-set! lst i v))
  (list->string lst))