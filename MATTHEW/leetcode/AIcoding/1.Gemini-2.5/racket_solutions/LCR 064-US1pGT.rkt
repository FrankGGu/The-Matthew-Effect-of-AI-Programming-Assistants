#lang racket

(struct magic-dictionary (words-set) #:mutable)

(define (magic-dictionary-build-dict this dict)
  (define new-set (make-hash-set))
  (for-each (lambda (word) (hash-set-add! new-set word)) dict)
  (set-magic-dictionary-words-set! this new-set))

(define (magic-dictionary-search this search-word)
  (define dict-set (magic-dictionary-words-set this))
  (define search-len (string-length search-word))

  (for/or ([dict-word (in-hash-set dict-set)])
    (and (= (string-length dict-word) search-len)
         (let loop ([i 0] [diff-count 0])
           (cond
             [(= i search-len) (= diff-count 1)]
             [(> diff-count 1) #f]
             [else
              (loop (+ i 1)
                    (if (char=? (string-ref dict-word i) (string-ref search-word i))
                        diff-count
                        (+ diff-count 1)))])))))