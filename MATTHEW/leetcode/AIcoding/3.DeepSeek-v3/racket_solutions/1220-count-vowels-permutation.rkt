#lang racket

(define (count-vowel-permutation n)
  (define MOD 1000000007)
  (if (= n 0)
      0
      (let loop ([a 1] [e 1] [i 1] [o 1] [u 1] [k 1])
        (if (= k n)
            (modulo (+ a e i o u) MOD)
            (let ([new-a (modulo e MOD)]
                  [new-e (modulo (+ a i) MOD)]
                  [new-i (modulo (+ a e o u) MOD)]
                  [new-o (modulo (+ i u) MOD)]
                  [new-u (modulo a MOD)])
              (loop new-a new-e new-i new-o new-u (+ k 1)))))))