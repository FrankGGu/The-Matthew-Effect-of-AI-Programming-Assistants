#lang racket

(define (first-unique-char s)
  (define char-counts (make-hash))
  (define len (string-length s))

  (for ([i (in-range len)])
    (define char (string-ref s i))
    (hash-set! char-counts char (add1 (hash-ref char-counts char 0))))

  (for ([i (in-range len)])
    (define char (string-ref s i))
    (when (= (hash-ref char-counts char) 1)
      (if (integer? i)
          i)))

  -1)