#lang racket

(define (soup-servings n)
  (define memo (make-hash))
  (define (dp a b)
    (cond [(>= a 0) (if (>= b 0) (hash-ref memo (cons a b) #f) 0.5)]
          [(>= b 0) 0.5]
          [else 1.0]))
  (define (helper a b)
    (if (hash-has-key? memo (cons a b))
        (hash-ref memo (cons a b))
        (let ([res (+ (* 0.25 (helper (- a 1) b))
                      (* 0.25 (helper a (- b 1)))
                      (* 0.25 (helper (- a 1) (- b 1)))
                      (* 0.25 (helper (- a 1) (- b 1))))])
          (hash-set! memo (cons a b) res)
          res)))
  (if (> n 480) 1.0 (helper n n)))