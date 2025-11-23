#lang racket

(define (possible-pairs rules)
  (for*/list ([a (in-range 1 7)]
              [b (in-range 1 7)]
              #:when (not (member (list a b) rules)))
    (list a b)))

(define (possible-flips rules)
  (for/list ([p (in-list (possible-pairs rules))])
    (if (equal? (car p) (cadr p))
        (list (car p))
        (list (car p) (cadr p)))))

(define (distinct-values rules)
  (define flips (possible-flips rules))
  (for/set ([f (in-list flips)])
    (set->list f)))

(define (card-flipping-game rules)
  (define values (distinct-values rules))
  (if (null? values)
      0
      (apply min (map length values))))