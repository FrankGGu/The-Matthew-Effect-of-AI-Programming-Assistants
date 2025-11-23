#lang racket

(define (report-spam-message message words count)
  (define word-set (list->set words))
  (define (check-word word)
    (set-member? word-set word))
  (define (count-words)
    (for/sum ([word (string-split message)])
      (if (check-word word) 1 0)))
  (>= (count-words) count))