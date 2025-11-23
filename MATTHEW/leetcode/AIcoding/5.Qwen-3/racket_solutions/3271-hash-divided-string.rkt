#lang racket

(define (get-indices s)
  (define (helper i res)
    (if (>= i (string-length s))
        res
        (helper (+ i 1) (cons (modulo i 26) res))))
  (reverse (helper 0 '())))

(define (hash-divided-string s k)
  (define indices (get-indices s))
  (define (split lst)
    (if (null? lst)
        '()
        (cons (take lst k) (split (drop lst k)))))
  (define parts (split indices))
  (define (convert-part p)
    (list->string (map (lambda (i) (integer->char (+ 97 i))) p)))
  (map convert-part parts))