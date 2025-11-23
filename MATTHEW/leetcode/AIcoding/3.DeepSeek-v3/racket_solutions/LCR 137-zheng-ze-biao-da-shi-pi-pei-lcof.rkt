#lang racket

(define (is-match s p)
  (define (helper s p si pi)
    (cond
      [(and (>= si (string-length s)) (>= pi (string-length p))]
      [(>= pi (string-length p)) #f]
      [(or (char=? (string-ref p pi) #\?)
           (char=? (string-ref s si) (string-ref p pi)))
       (helper s p (add1 si) (add1 pi))]
      [(char=? (string-ref p pi) #\*)
       (or (helper s p si (add1 pi))
           (helper s p (add1 si) pi))]
      [else #f]))
  (helper s p 0 0))