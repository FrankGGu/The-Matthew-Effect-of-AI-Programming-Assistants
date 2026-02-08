#lang racket

(define (allPossibleFBT n)
  (if (odd? n)
      (define (helper n)
        (if (= n 1)
            (list (list '()))
            (for/fold ([result '()])
                      ([i (in-range 1 n 2)])
              (for*/list ([left (helper (- i 1))]
                           [right (helper (- n i -1))])
                (cons (list '()) (append left right)))))
      '()))

(define (allPossibleFBT n)
  (if (odd? n)
      (define (build-trees n)
        (if (= n 1)
            (list (list '()))
            (for/fold ([trees '()])
                      ([i (in-range 1 n 2)])
              (for*/list ([left (build-trees (- i 1))]
                           [right (build-trees (- n i -1))])
                (cons (list '()) (append left right)))))
      '()))

(define (allPossibleFBT n)
  (if (odd? n)
      (define (build-trees n)
        (if (= n 1)
            (list (list '()))
            (for/fold ([trees '()])
                      ([i (in-range 1 n 2)])
              (for*/list ([left (build-trees (- i 1))]
                           [right (build-trees (- n i -1))])
                (cons (list '()) (append left right)))))
      '()))

(define (allPossibleFBT n)
  (if (odd? n)
      (define (build-trees n)
        (if (= n 1)
            (list (list '()))
            (for/fold ([trees '()])
                      ([i (in-range 1 n 2)])
              (for*/list ([left (build-trees (- i 1))]
                           [right (build-trees (- n i -1))])
                (cons (list '()) (append left right)))))
      '()))