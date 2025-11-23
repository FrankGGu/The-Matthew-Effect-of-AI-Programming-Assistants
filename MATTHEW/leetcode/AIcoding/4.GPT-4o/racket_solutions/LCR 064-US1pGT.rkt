#lang racket

(define MagicDictionary
  (struct magic-dictionary (words) #:transparent))

(define (magic-dictionary-create)
  (magic-dictionary (hash)))

(define (magic-dictionary-build dict word)
  (define words (magic-dictionary-words dict))
  (hash-set! words word #t)
  (magic-dictionary words))

(define (magic-dictionary-search dict search-word)
  (define words (magic-dictionary-words dict))
  (for/or ([word (in-hash-keys words)])
    (let loop ([i 0] [diff 0])
      (cond
        [(= i (string-length search-word))
         (= diff 1)]
        [else
         (loop (+ i 1) 
               (if (char=? (string-ref search-word i) (string-ref word i)) 
                   diff 
                   (+ diff 1)))]))))

(define (magic-dictionary-words dict)
  (magic-dictionary-words dict))