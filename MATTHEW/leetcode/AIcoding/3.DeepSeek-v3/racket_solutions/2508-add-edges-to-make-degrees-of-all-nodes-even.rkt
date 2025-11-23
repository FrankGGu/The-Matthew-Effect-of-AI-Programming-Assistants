#lang racket

(define (is-possible n edges)
  (define adj (make-hash))
  (for ([edge edges])
    (define u (car edge))
    (define v (cadr edge))
    (hash-update! adj u (lambda (lst) (cons v lst)) '())
    (hash-update! adj v (lambda (lst) (cons u lst)) '()))

  (define odd-degrees
    (for/list ([i (in-range 1 (add1 n))]
               #:when (odd? (length (hash-ref adj i '()))))
               i))

  (define cnt (length odd-degrees))
  (cond
    [(= cnt 0) #t]
    [(= cnt 2)
     (define u (car odd-degrees))
     (define v (cadr odd-degrees))
     (or (not (member v (hash-ref adj u '())))
         (let ([common
                (for/sum ([k (in-range 1 (add1 n))]
                  (if (and (member k (hash-ref adj u '()))
                           (member k (hash-ref adj v '())))
                      1 0))])
           (>= common 1)))]
    [(= cnt 4)
     (define a (list-ref odd-degrees 0))
     (define b (list-ref odd-degrees 1))
     (define c (list-ref odd-degrees 2))
     (define d (list-ref odd-degrees 3))
     (or (and (not (member b (hash-ref adj a '())))
              (not (member d (hash-ref adj c '()))))
         (and (not (member c (hash-ref adj a '())))
              (not (member d (hash-ref adj b '()))))
         (and (not (member d (hash-ref adj a '())))
              (not (member c (hash-ref adj b '()))))]
    [else #f]))