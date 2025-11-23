#lang racket

(define (are-occurrences-equal s)
  (define char-counts (make-hash))

  (for ([char (string->list s)])
    (hash-update! char-counts char add1 0))

  (define counts (hash-values char-counts))

  (cond
    [(empty? counts) #t] ; Empty string or no characters means all counts are vacuously equal
    [else
     (apply = (hash-values char-counts))]))