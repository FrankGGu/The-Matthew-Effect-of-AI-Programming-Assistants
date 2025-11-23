(define (vowel-spellchecker wordlist queries)
  (define (normalize-vowel str)
    (string-replace* (string-downcase str)
                      '(#\a #\e #\i #\o #\u)
                      '(#\* #\* #\* #\* #\*)))

  (define exact-set (make-hash))
  (define case-insensitive-set (make-hash))
  (define vowel-insensitive-set (make-hash))

  (for ([word wordlist])
    (hash-set! exact-set word #t)
    (let ([lower-word (string-downcase word)])
      (unless (hash-has-key? case-insensitive-set lower-word)
        (hash-set! case-insensitive-set lower-word word))
      (let ([vowel-word (normalize-vowel word)])
        (unless (hash-has-key? vowel-insensitive-set vowel-word)
          (hash-set! vowel-insensitive-set vowel-word word)))))

  (define (check-query query)
    (cond
      [(hash-has-key? exact-set query) query]
      [(hash-has-key? case-insensitive-set (string-downcase query))
       (hash-ref case-insensitive-set (string-downcase query))]
      [(hash-has-key? vowel-insensitive-set (normalize-vowel query))
       (hash-ref vowel-insensitive-set (normalize-vowel query))]
      [else ""]))

  (map check-query queries))