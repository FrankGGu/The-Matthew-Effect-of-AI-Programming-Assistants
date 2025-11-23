#lang racket

(define (findStableArrays n)
  (define (helper p used)
    (if (= (length p) n)
        (list p)
        (for*/list ([i (in-range 0 2)]
                     #:when (not (or (and (= i 1) (equal? (car (last p)) 1))
                                     (and (= i 0) (equal? (car (last p)) 0) (not (equal? (length used) 0))))))
          (helper (append p (list i)) (append used (list i))))))

  (helper '() '()))

(define (findAllPossibleStableBinaryArrays n)
  (findStableArrays n))