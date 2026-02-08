#lang racket

(define (solution s)
  (define vowels-list '(#\a #\e #\i #\o #\u))
  (define consonants-list '(#\b #\c #\d #\f #\g #\h #\j #\k #\l #\m #\n #\p #\q #\r #\s #\t #\v #\w #\x #\y #\z))

  (define (vowel? c)
    (member c vowels-list))

  (define (consonant? c)
    (member c consonants-list))

  (define vowel-counts (make-hash))
  (define consonant-counts (make-hash))

  (for ([char (string->list s)])
    (cond
      [(vowel? char)
       (hash-update! vowel-counts char add1 0)]
      [(consonant? char)
       (hash-update! consonant-counts char add1 0)]))

  (define (find-most-frequent counts-ht char-options default-char)
    (let loop ([max-count -1]
               [most-freq-char default-char]
               [options char-options])
      (if (null? options)
          most-freq-char
          (let* ([current-char (car options)]
                 [current-count (hash-ref counts-ht current-char 0)])
            (if (> current-count max-count)
                (loop current-count current-char (cdr options))
                (loop max-count most-freq-char (cdr options)))))))

  (define most-frequent-vowel
    (find-most-frequent vowel-counts vowels-list #\a))

  (define most-frequent-consonant
    (find-most-frequent consonant-counts consonants-list #\b))

  (string most-frequent-vowel most-frequent-consonant))