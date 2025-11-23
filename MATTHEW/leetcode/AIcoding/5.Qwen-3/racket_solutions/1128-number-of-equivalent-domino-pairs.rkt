#lang racket

(define (num-equivalent-pairs dominoes)
  (define (count-pairs n)
    (if (< n 2) 0 (* n (- n 1)) ))
  (define freq (make-hash))
  (for-each
   (lambda (d)
     (let* ([a (car d)]
            [b (cadr d)]
            [key (if (< a b) (cons a b) (cons b a))])
       (hash-set! freq key (+ 1 (hash-ref freq key 0)))))
   dominoes)
  (apply + (map count-pairs (hash-values freq))))