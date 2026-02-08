(define (most-frequent-vowel-and-consonant s)
  (define vowels (set #\a #\e #\i #\o #\u))
  (define freq (make-hash))
  (define (char->lower c)
    (if (char-upper-case? c)
        (char-downcase c)
        c))
  (for ([c (in-string s)])
    (when (char-alphabetic? c)
      (let ([lc (char->lower c)])
        (hash-update! freq lc add1 0))))
  (define (get-max-char chars)
    (if (null? chars)
        #f
        (let loop ([chars chars]
                   [max-char (car chars)]
                   [max-count (hash-ref freq (car chars) 0)])
          (cond [(null? chars) max-char]
                [(> (hash-ref freq (car chars)) max-count)
                 (loop (cdr chars) (car chars) (hash-ref freq (car chars)))]
                [(= (hash-ref freq (car chars)) max-count)
                 (loop (cdr chars) (min max-char (car chars)) max-count)]
                [else (loop (cdr chars) max-char max-count)]))))
  (define vowel-chars (filter (lambda (c) (set-member? vowels c)) (hash-keys freq)))
  (define consonant-chars (filter (lambda (c) (not (set-member? vowels c))) (hash-keys freq)))
  (define most-vowel (get-max-char vowel-chars))
  (define most-consonant (get-max-char consonant-chars))
  (list (or most-vowel #\a) (or most-consonant #\b)))