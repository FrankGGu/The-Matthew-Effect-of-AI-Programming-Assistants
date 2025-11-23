#lang racket

(define (max-interval-length nums)
  (define freq (make-hash))
  (define (update-freq x)
    (hash-set! freq x (+ (hash-ref freq x 0) 1)))
  (for-each update-freq nums)
  (define odd (filter (lambda (x) (= (modulo x 2) 1)) (hash-keys freq)))
  (define even (filter (lambda (x) (= (modulo x 2) 0)) (hash-keys freq)))
  (define (get-max lst)
    (if (null? lst)
        0
        (apply max (map (lambda (x) (hash-ref freq x)) lst))))
  (define max-odd (get-max odd))
  (define max-even (get-max even))
  (abs (- max-odd max-even)))