#lang racket

(define (count-vowels-consonants s)
  (define vowels (set #\a #\e #\i #\o #\u))
  (define (helper str v c)
    (cond [(empty? str) (values v c)]
          [(set-member? vowels (car str)) (helper (cdr str) (add1 v) c)]
          [(char-alphabetic? (car str)) (helper (cdr str) v (add1 c))]
          [else (helper (cdr str) v c)]))
  (helper (string->list s) 0 0))

(define (most-frequent-vowel-consonant s)
  (define-values (v c) (count-vowels-consonants s))
  (define (get-max v c)
    (cond [(> v c) (list #\vowel v)]
          [(< v c) (list #\consonant c)]
          [else (list #\tie v)]))
  (get-max v c))