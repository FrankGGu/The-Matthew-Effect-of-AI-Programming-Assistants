#lang racket

(define (group-strings strings)
  (define (get-key s)
    (define lst (map char->integer (string->list s)))
    (define diff (for/list ([i (in-range 1 (length lst))])
                   (modulo (- (list-ref lst i) (list-ref lst (- i 1))) 26)))
    diff)
  (define groups (make-hash))
  (for ([s strings])
    (define key (get-key s))
    (hash-update! groups key (lambda (v) (cons s v)) '()))
  (hash-values groups))