#lang racket

(define (is-vowel? char)
  (member (char-downcase char) '(#\a #\e #\i #\o #\u)))

(define (count-vowels s)
  (for/sum ([c (in-string s)])
    (if (is-vowel? c) 1 0)))

(define (halves-are-alike s)
  (let* ([len (string-length s)]
         [mid (/ len 2)]
         [s1 (substring s 0 mid)]
         [s2 (substring s mid len)])
    (= (count-vowels s1) (count-vowels s2))))