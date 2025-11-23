#lang racket

(define (count-stepping-numbers-in-range low high)
  (define (is-stepping? n)
    (define (helper prev digit)
      (if (= digit 0)
          #t
          (and (abs (- prev digit)) 1)
          (helper digit (quotient digit 10))))
    (helper -1 n))

  (define (generate-stepping start)
    (define (dfs num res)
      (if (> num high)
          res
          (if (and (>= num low) (is-stepping? num))
              (dfs (add1 num) (cons num res))
              (dfs (add1 num) res))))
    (reverse (dfs start '())))

  (length (generate-stepping 0)))