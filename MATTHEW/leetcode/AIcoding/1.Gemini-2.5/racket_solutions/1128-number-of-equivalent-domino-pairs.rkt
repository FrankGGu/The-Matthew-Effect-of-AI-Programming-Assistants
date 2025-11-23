#lang racket

(define (num-equivalent-domino-pairs dominoes)
  (let ([counts (make-hash)])
    (for-each (lambda (domino)
                (let* ([a (car domino)]
                       [b (cadr domino)]
                       [normalized-domino (list (min a b) (max a b))])
                  (hash-set! counts normalized-domino
                             (+ 1 (hash-ref counts normalized-domino 0)))))
              dominoes)
    (let ([total-pairs 0])
      (hash-for-each (lambda (_ count)
                       (set! total-pairs (+ total-pairs (/ (* count (- count 1)) 2))))
                     counts)
      total-pairs)))