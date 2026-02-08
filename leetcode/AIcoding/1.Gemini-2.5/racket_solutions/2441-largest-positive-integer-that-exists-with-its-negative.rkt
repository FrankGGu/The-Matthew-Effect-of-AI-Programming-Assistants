#lang racket
(require racket/set)
(require racket/list)

(define (find-max-k nums)
  (define num-set (list->set nums))
  (define positive-numbers
    (sort (filter (lambda (n) (> n 0)) nums) >))

  (define result
    (for/first ([k (in-list positive-numbers)]
                #:when (set-member? num-set (- k)))
      k))

  (if result
      result
      -1))