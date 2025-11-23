#lang racket

(define (extract-words s)
  (define (helper s res)
    (cond [(string=? s "") res]
          [(char-whitespace? (string-ref s 0))
           (helper (substring s 1) res)]
          [else
           (let loop ([i 0])
             (if (or (= i (string-length s)) (char-whitespace? (string-ref s i)))
                 (cons (substring s 0 i) res)
                 (loop (+ i 1))))]))
  (reverse (helper s '())))

(define (extract-curse-word s)
  (define words (extract-words s))
  (define (count-vowels word)
    (length (filter (lambda (c) (member c '(#\a #\e #\i #\o #\u))) (string->list word))))
  (define (is-valid word)
    (and (> (string-length word) 2)
         (>= (count-vowels word) 2)))
  (string-join (filter is-valid words) " "))