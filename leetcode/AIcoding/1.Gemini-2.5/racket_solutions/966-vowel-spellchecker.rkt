#lang racket

(define (vowel-pattern-string s)
  (let* ([lower-s (string-downcase s)]
         [chars (string->list lower-s)]
         [pattern-chars (map (lambda (c)
                               (case c
                                 [(#\a #\e #\i #\o #\u) #\*]
                                 [else c]))
                             chars)])
    (list->string pattern-chars)))

(define (spellchecker wordlist queries)
  (let ([exact-matches (make-hash)]
        [case-insensitive-map (make-hash)]
        [vowel-pattern-map (make-hash)])

    (for-each (lambda (word)
                (hash-set! exact-matches word #t)

                (let ([lower-word (string-downcase word)])
                  (unless (hash-has-key? case-insensitive-map lower-word)
                    (hash-set! case-insensitive-map lower-word word)))

                (let ([pattern-word (vowel-pattern-string word)])
                  (unless (hash-has-key? vowel-pattern-map pattern-word)
                    (hash-set! vowel-pattern-map pattern-word word))))
              wordlist)

    (map (lambda (query)
           (cond
             [(hash-has-key? exact-matches query)
              query]

             [(let ([lower-query (string-downcase query)])
                (hash-has-key? case-insensitive-map lower-query))
              (hash-ref case-insensitive-map (string-downcase query))]

             [(let ([pattern-query (vowel-pattern-string query)])
                (hash-has-key? vowel-pattern-map pattern-query))
              (hash-ref vowel-pattern-map (vowel-pattern-string query))]

             [else
              ""]))
         queries)))