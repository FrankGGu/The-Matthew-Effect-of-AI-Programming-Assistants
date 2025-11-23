#lang racket

(define (most-common-word paragraph banned)
  (define banned-set (set .apply. (string-split banned " ")))
  (define words (string-split (regexp-replace* #rx"[^a-zA-Z0-9 ]" paragraph "") " "))
  (define freq (make-hash))
  (for-each
   (lambda (word)
     (when (and (not (set-member? banned-set word)) (> (string-length word) 0))
       (hash-update! freq (string-downcase word) add1 0)))
   words)
  (define max-count 0)
  (define result "")
  (for-each
   (lambda (k v)
     (when (> v max-count)
       (set! max-count v)
       (set! result k)))
   (hash->list freq))
  result)