#lang racket

(define (count-words-in-paragraph paragraph)
  (define (is-letter? c)
    (and (char>=? c #\a) (char<=? c #\z)))
  (define (split-words s)
    (let loop ([s s] [current-word '()] [words '()])
      (cond [(null? s) (if (null? current-word) words (cons (reverse current-word) words))]
            [(is-letter? (car s))
             (loop (cdr s) (cons (car s) current-word) words)]
            [else
             (loop (cdr s) '() (if (null? current-word) words (cons (reverse current-word) words)))]))
  (define (lowercase-word word)
    (map char-downcase word))
  (define (normalize-word word)
    (string->list (string-downcase (list->string word))))
  (define (word-counts words)
    (foldl (lambda (word acc)
             (hash-update acc (normalize-word word) add1 0))
           (hash) words))
  (define (get-words paragraph)
    (split-words (string->list paragraph)))
  (define (get-banned-set banned)
    (for/hash ([b (in-list banned)])
      (values (string->list b) #t)))
  (define (is-banned? word banned-set)
    (hash-has-key? banned-set (normalize-word word)))
  (define (filter-banned words banned-set)
    (filter (lambda (word) (not (is-banned? word banned-set))) words))
  (define (get-most-frequent-word counts)
    (define (compare a b)
      (> (hash-ref counts a) (hash-ref counts b)))
    (argmax (lambda (k) (hash-ref counts k)) (hash-keys counts)))
  (let* ([words (get-words paragraph)]
         [banned-set (get-banned-set banned)]
         [filtered-words (filter-banned words banned-set)]
         [counts (word-counts filtered-words)]
         [most-frequent (get-most-frequent-word counts)])
    (list->string most-frequent)))