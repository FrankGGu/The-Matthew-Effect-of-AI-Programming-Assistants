#lang racket

(define (checkValidGrid grid)
  (define n (vector-length grid))
  (define positions (make-hash))

  (for ([i (in-range n)])
    (for ([j (in-range n)])
      (hash-set! positions (vector-ref (vector-ref grid i) j) (cons i j)))

  (unless (equal? (hash-ref positions 0) '(0 . 0)) (return #f))

  (for ([k (in-range 1 (* n n))])
    (define prev (hash-ref positions (- k 1)))
    (define curr (hash-ref positions k))
    (define dx (abs (- (car curr) (car prev))))
    (define dy (abs (- (cdr curr) (cdr prev))))
    (unless (or (and (= dx 1) (= dy 2)) (and (= dx 2) (= dy 1)))
      (return #f)))

  #t)

(define-syntax-rule (return x) x)