#lang racket

(define (can-attack? keymap s)
  (define keyset (string->list keymap))
  (define slist (string->list s))
  (for/and ([c slist])
    (member c keyset)))

(define (count-words-by-keyboard keymaps s)
  (define slist (string->list s))
  (define (count words)
    (if (null? words)
        0
        (+ (if (can-attack? (car words) s) 1 0)
           (count (cdr words)))))
  (count keymaps))

(define (main)
  (define input (read-line))
  (define keymaps (string-split input #\space))
  (define s (read-line))
  (display (count-words-by-keyboard keymaps s)))

(main)