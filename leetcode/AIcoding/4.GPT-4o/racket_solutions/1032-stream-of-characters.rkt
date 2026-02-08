#lang racket

(define StreamOfCharacters
  (class object%
    (super-new)

    (define/public (isPrefix(word))
      (define result #f)
      (for ([s (in-list '("a" "b" "c"))])
        (when (string-prefix? word s)
          (set! result #t)))
      result)

    (define/public (query(letter))
      (define word (string letter))
      (isPrefix word))

    (define/public (insert(letter))
      (define word (string letter))
      (isPrefix word))

    (define/public (f(word))
      (insert word)
      (query word))

    (define/public (reset())
      (void))
  ))