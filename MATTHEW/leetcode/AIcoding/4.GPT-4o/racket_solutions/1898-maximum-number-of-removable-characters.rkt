#lang racket

(define (can-remove s p removable mid)
  (define chars (map (lambda (i) (if (member i removable) #f #t)) (range (length s))))
  (define s' (apply string (filter (lambda (x) x) chars)))
  (string-contains? s' p))

(define (maximum-removable s p removable)
  (define lo 0)
  (define hi (length removable))
  (define result 0)

  (define (binary-search)
    (if (<= lo hi)
        (let ([mid (quotient (+ lo hi) 2)])
          (if (can-remove s p (take removable mid))
              (begin (set! result mid)
                     (set! lo (+ mid 1))
                     (binary-search))
              (begin (set! hi (- mid 1))
                     (binary-search)))
          result)))

  (binary-search))