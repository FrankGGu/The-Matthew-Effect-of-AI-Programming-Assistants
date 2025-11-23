#lang racket

(define (uncommon-words-from-two-sentences paragraph1 paragraph2)
  (define (count-words s)
    (for/fold ([counts (hash)])
              ([word (in-list (string-split s))])
      (hash-update counts word add1 0)))

  (define counts1 (count-words paragraph1))
  (define counts2 (count-words paragraph2))

  (define (is-uncommon word)
    (and (= (hash-ref counts1 word 0) 1)
         (= (hash-ref counts2 word 0) 1)))

  (filter is-uncommon (append (string-split paragraph1) (string-split paragraph2))))