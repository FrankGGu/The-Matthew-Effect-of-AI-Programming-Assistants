#lang racket

(define (num-identical-pairs nums)
  (define (count-occurrences lst)
    (for/fold ([counts (hash)]) ([n lst])
      (hash-update counts n add1 0)))

  (define (gcd a b)
    (if (= b 0)
        a
        (gcd b (modulo a b))))

  (define (reduce-fraction a b)
    (let ([g (gcd a b)])
      (values (/ a g) (/ b g))))

  (define (key->ratio key)
    (let* ([w (car key)]
           [h (cdr key)]
           [g (gcd w h)])
      (cons (/ w g) (/ h g))))

  (define ratios (map key->ratio nums))
  (define count (count-occurrences ratios))

  (for/sum ([v (in-hash-values count)])
    (* v (- v 1)) 1/2))