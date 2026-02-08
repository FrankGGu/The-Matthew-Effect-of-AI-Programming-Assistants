#lang racket

(define (count-chars s)
  (define char-counts (make-hash))
  (for-each
   (lambda (char)
     (hash-set! char-counts char (+ (hash-ref char-counts char 0) 1)))
   (string->list s))
  char-counts)

(define (rearrange-characters s target)
  (define s-counts (count-chars s))
  (define target-counts (count-chars target))

  (define min-copies (add1 (string-length s)))

  (for-each
   (lambda (char)
     (define target-char-count (hash-ref target-counts char 0))
     (define s-char-count (hash-ref s-counts char 0))
     (set! min-copies (min min-copies (floor (/ s-char-count target-char-count)))))
   (hash-keys target-counts))

  min-copies)