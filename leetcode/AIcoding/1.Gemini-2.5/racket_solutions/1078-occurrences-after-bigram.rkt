#lang racket

(require racket/string)

(define (find-occurrences text first second)
  (let* ([words (string-split text " ")]
         [n (length words)])
    (define (loop i acc)
      (if (>= (+ i 2) n)
          (reverse acc)
          (let ([w1 (list-ref words i)]
                [w2 (list-ref words (+ i 1))]
                [w3 (list-ref words (+ i 2))])
            (if (and (string=? w1 first)
                     (string=? w2 second))
                (loop (+ i 1) (cons w3 acc))
                (loop (+ i 1) acc)))))
    (loop 0 '())))