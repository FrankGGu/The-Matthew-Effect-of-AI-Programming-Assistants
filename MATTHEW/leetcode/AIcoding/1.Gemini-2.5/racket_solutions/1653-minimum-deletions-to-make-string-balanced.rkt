#lang racket

(define (minimum-deletions s)
  (define n (string-length s))

  (define total-a-count 0)
  (for ([c (in-string s)])
    (when (char=? c #\a)
      (set! total-a-count (+ total-a-count 1))))

  (define b-count-so-far 0)
  (define a-count-remaining total-a-count)

  (define min-deletions total-a-count)

  (for ([j (in-range n)])
    (define current-char (string-ref s j))
    (if (char=? current-char #\a)
        (set! a-count-remaining (- a-count-remaining 1))
        (set! b-count-so-far (+ b-count-so-far 1)))

    (set! min-deletions (min min-deletions (+ b-count-so-far a-count-remaining))))

  min-deletions)