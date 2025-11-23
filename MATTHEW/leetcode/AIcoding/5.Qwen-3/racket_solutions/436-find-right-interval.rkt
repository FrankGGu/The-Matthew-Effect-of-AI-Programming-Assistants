#lang racket

(define (find-right-interval intervals)
  (define (cmp a b)
    (< (car a) (car b)))
  (define sorted (sort (map (lambda (x) (cons x (index-of intervals x))) intervals) cmp))
  (define (search target lst)
    (cond [(null? lst) -1]
          [else
           (let ([mid (quotient (length lst) 2)]
                 [val (caar lst)])
             (if (= val target)
                 (cdar lst)
                 (if (< target val)
                     (search target (take lst mid))
                     (let ([res (search target (drop lst (add1 mid)))]
                           [idx (cdar lst)])
                       (if (= res -1) idx res))))]))
  (map (lambda (x) (search (car x) sorted)) intervals))