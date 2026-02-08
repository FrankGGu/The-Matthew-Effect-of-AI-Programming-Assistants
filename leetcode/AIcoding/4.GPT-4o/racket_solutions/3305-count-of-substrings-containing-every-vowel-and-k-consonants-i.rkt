#lang racket

(define (count-substrings s k)
  (define vowels (set '(#\a #\e #\i #\o #\u)))
  (define (valid-substring? substring)
    (define consonant-count (define (count-consonants str)
                               (length (filter (lambda (c) (and (char? c) (not (set-member? vowels c)))) str)))
      (and (every? (lambda (v) (string-contains? substring (string v))) vowels)
           (<= (count-consonants substring) k)))
  (define (count-valid substrings)
    (length (filter valid-substring? substrings)))
  (define (generate-substrings str)
    (for/fold ([subs '()]) ([i (in-range (string-length str))])
      (for/fold ([new-subs subs]) ([j (in-range i (string-length str))])
        (cons (substring str i (add1 j)) new-subs))))
  (count-valid (generate-substrings s)))

(define (main)
  (define s (read-line))
  (define k (read))
  (display (count-substrings s k)))

(main)