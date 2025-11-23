#lang racket

(define (shift-distance s t)
  (define n (string-length s))
  (define m (string-length t))
  (if (not (= n m)) -1
      (let loop ([i 0] [res 0])
        (if (= i n) res
            (let ([si (string-ref s i)]
                  [ti (string-ref t i)])
              (if (= si ti) (loop (+ i 1) res)
                  (let ([d (modulo (- (char->integer ti) (char->integer si)) 26)])
                    (loop (+ i 1) (+ res d)))))))))