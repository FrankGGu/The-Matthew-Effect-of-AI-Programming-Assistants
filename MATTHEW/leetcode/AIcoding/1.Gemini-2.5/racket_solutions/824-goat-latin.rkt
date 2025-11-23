#lang racket/base

(define (to-goat-latin sentence)
  (define (vowel? c)
    (member (char-downcase c) '(#\a #\e #\i #\o #\u)))

  (define (transform-word word index)
    (define first-char (string-ref word 0))
    (define base-word
      (if (vowel? first-char)
          word
          (string-append (substring word 1) (string first-char))))
    (define suffix-a (make-string (+ index 1) #\a))
    (string-append base-word "ma" suffix-a))

  (define words (string-split sentence " "))
  (define transformed-words
    (for/list ([word (in-list words)]
               [idx (in-naturals)])
      (transform-word word idx)))

  (string-join transformed-words " "))