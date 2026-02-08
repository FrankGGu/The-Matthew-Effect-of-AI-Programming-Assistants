#lang racket

(define (intersection-of-multiple-arrays nums)
  (if (empty? nums)
      '()
      (let* ([first-list-set (list->set (car nums))]
             [final-set (foldl (lambda (current-list acc-set)
                                 (set-intersect acc-set (list->set current-list)))
                               first-list-set
                               (cdr nums))]
             [result-list (set->list final-set)])
        (sort result-list <))))