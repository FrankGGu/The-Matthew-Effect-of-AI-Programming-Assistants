#lang racket

(require racket/set)

(define (can-be-typed-words text brokenLetters)
  (define broken-set (list->set (string->list brokenLetters)))
  (define words (string-split text " "))

  (define (word-typable? word)
    (for/and ([char (in-list (string->list word))])
      (not (set-member? broken-set char))))

  (for/sum ([word (in-list words)])
    (if (word-typable? word) 1 0)))