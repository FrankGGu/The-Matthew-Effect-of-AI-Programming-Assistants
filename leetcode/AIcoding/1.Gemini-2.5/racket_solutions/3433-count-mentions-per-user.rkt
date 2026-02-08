#lang racket

(define (count-mentions-per-user posts)
  (define counts (make-hash))
  (define mention-regex #rx"@([a-zA-Z0-9_]+)")

  (for-each
   (lambda (post)
     (for-each
      (lambda (match)
        (define username (second match))
        (hash-update! counts username add1 0))
      (regexp-match* mention-regex post)))
   posts)

  (hash->list counts))