#lang racket

(struct encrypter (key-to-value-map encrypted-dictionary-counts) #:transparent)

(define (encrypt-word-internal key-to-value-map word)
  (string-join
   (map (lambda (char)
          (hash-ref key-to-value-map char))
        (string->list word))
   ""))

(define (make-encrypter keys values dictionary)
  (define key-map
    (for/fold ([m (hash)])
              ([k keys]
               [v values])
      (hash-set m k v)))

  (define encrypted-counts
    (for/fold ([counts (hash)])
              ([dict-word dictionary])
      (define encrypted-form (encrypt-word-internal key-map dict-word))
      (hash-update counts encrypted-form add1 0)))

  (encrypter key-map encrypted-counts))

(define (encrypter-encrypt this word1)
  (encrypt-word-internal (encrypter-key-to-value-map this) word1))

(define (encrypter-decrypt this word2)
  (hash-ref (encrypter-encrypted-dictionary-counts this) word2 0))