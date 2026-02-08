#lang racket
(require racket/set)

(define (find-unique-binary-string nums)
  (define n (string-length (car nums)))
  (define nums-set (list->set nums))

  (let loop ([i 0])
    (define current-binary-string (format "~v,'0b" n i))
    (if (set-member? nums-set current-binary-string)
        (loop (+ i 1))
        current-binary-string)))