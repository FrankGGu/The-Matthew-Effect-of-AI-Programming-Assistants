(define (spellchecker wordlist queries)
  (define vowels (set #\a #\e #\i #\o #\u))
  (define (vowel-mask c)
    (if (set-member? vowels (char-downcase c)) #\# (char-downcase c)))
  (define (to-devowel s)
    (list->string (map vowel-mask (string->list s))))

  (define exact (make-hash))
  (define case-insensitive (make-hash))
  (define devoweled (make-hash))

  (for ([word wordlist])
    (hash-set! exact word #t)
    (define lower (string-downcase word))
    (unless (hash-has-key? case-insensitive lower)
      (hash-set! case-insensitive lower word))
    (define devowel (to-devowel lower))
    (unless (hash-has-key? devoweled devowel)
      (hash-set! devoweled devowel word)))

  (define (query-result q)
    (cond
      [(hash-has-key? exact q) q]
      [else
       (define lower (string-downcase q))
       (define res (hash-ref case-insensitive lower #f))
       (if res res
           (let ([devowel (to-devowel lower)])
             (hash-ref devoweled devowel "")))]))

  (map query-result queries))