#lang racket

(define (encode long-url)
  (define chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
  (define (random-string len)
    (for/fold ([s ""]) ([i (in-range len)])
      (string-append s (string-ref chars (random (string-length chars))))))
  (define short-url (random-string 6))
  (hash-set! (current-namespace) 'url-map (hash-set (hash-ref (current-namespace) 'url-map) short-url long-url))
  short-url)

(define (decode short-url)
  (hash-ref (hash-ref (current-namespace) 'url-map) short-url))

(define url-map (make-hash))