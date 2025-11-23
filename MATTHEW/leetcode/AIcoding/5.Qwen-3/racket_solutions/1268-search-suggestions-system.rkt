#lang racket

(define (search-suggestions-system products search-word)
  (define (sort-products p)
    (sort p string<?))

  (define (get-suggestions p prefix)
    (filter (lambda (s) (and (>= (string-length s) (string-length prefix))
                             (equal? (substring s 0 (string-length prefix)) prefix)))
            p))

  (define sorted-products (sort-products products))
  (define result '())
  (define prefix "")
  (for ([c (in-string search-word)])
    (set! prefix (string-append prefix (string c)))
    (set! result (cons (take (get-suggestions sorted-products prefix) 3) result)))
  (reverse result))