#lang racket

(require racket/set)

(define (partition-string s)
  (for/fold ([partitions 1]
             [current-chars (set)])
            ([c (in-string s)])
    (if (set-member? current-chars c)
        (values (+ partitions 1) (set c))
        (values partitions (set-add current-chars c)))))