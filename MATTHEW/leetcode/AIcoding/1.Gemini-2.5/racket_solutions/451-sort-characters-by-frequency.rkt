#lang racket

(define (frequencySort s)
  (define char-counts (make-hash))

  (for ([c (in-string s)])
    (hash-update! char-counts c add1 0))

  (define char-count-list (hash->list char-counts))

  (define sorted-chars
    (sort char-count-list
          (lambda (item1 item2)
            (> (cdr item1) (cdr item2)))))

  (define sb (open-string-builder))
  (for ([pair sorted-chars])
    (define char (car pair))
    (define count (cdr pair))
    (for ([_ (in-range count)])
      (string-builder-add-char! sb char)))

  (string-builder-get-string sb))