#lang racket

(define (group-anagrams strs)
  (define anagram-map (make-hash))

  (for-each (lambda (s)
              (define sorted-s (list->string (sort (string->list s) char<?)))
              (hash-set! anagram-map sorted-s
                         (cons s (hash-ref anagram-map sorted-s '()))))
            strs)

  (hash-values anagram-map))