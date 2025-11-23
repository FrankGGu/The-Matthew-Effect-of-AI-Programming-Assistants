#lang racket

(define (spellchecker wordlist query)
  (define (to-key s)
    (string-downcase
     (regexp-replace* #px"[aeiou]" s "a")))

  (define wordset (set .apply. wordlist))
  (define vowelmap (make-hash))
  (for ([word wordlist])
    (hash-set! vowelmap (to-key word) #t))

  (define (check q)
    (cond [(set-member? wordset q) 'correct]
          [(hash-has-key? vowelmap (to-key q)) 'vowel]
          [else 'incorrect]))

  (map check query))