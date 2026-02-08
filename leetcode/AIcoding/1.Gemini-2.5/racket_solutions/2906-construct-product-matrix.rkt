#lang racket

(define (construct-product-matrix grid)
  (define MOD 12345)

  (define (mod-mult a b)
    (modulo (* a b) MOD))

  (define n (length grid))
  (define m (length (car grid)))

  (define flat-grid (apply append grid))
  (define N (length flat-grid))

  (define pp
    (let loop ((lst flat-grid) (current-prod 1) (acc '(1)))
      (if (empty? lst)
          (reverse acc)
          (loop (cdr lst)
                (mod-mult current-prod (car lst))
                (cons (mod-mult current-prod (car lst)) acc)))))

  (define sp
    (let loop ((lst (reverse flat-grid)) (current-prod 1) (acc '(1)))
      (if (empty? lst)
          acc
          (loop (cdr lst)
                (mod-mult current-prod (car lst))
                (cons (mod-mult current-prod (car lst)) acc)))))

  (define flat-P
    (let loop ((pp-tail pp) (sp-tail (cdr sp)) (acc '()))
      (if (or (empty? pp-tail) (empty? sp-tail))
          (reverse acc)
          (loop (cdr pp-tail)
                (cdr sp-tail)
                (cons (mod-mult (car pp-tail) (car sp-tail)) acc)))))

  (define (reshape lst n m)
    (let loop ((i 0) (current-lst lst) (result '()))
      (if (= i n)
          (reverse result)
          (loop (add1 i)
                (drop current-lst m)
                (cons (take current-lst m) result)))))

  (reshape flat-P n m))