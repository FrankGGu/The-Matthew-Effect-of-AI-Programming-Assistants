#lang racket

(require racket/string)

(define (is-prefix-of-word sentence searchWord)
  (let* ([words (string-split sentence " ")]
         [num-words (length words)])
    (let loop ([i 0])
      (if (< i num-words)
          (let ([current-word (list-ref words i)])
            (if (string-prefix? searchWord current-word)
                (+ i 1)
                (loop (+ i 1))))
          -1))))