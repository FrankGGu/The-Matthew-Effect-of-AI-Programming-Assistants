#lang racket

(define MOD 1000000007)

(define (is-prime c)
  (or (char=? c #\2) (char=? c #\3) (char=? c #\5) (char=? c #\7)))

(define (beautiful-partitions s k min-length)
  (let* ([n (string-length s)]
         [dp (make-vector (add1 n) 0)]
         [prefix (make-vector (add1 n) 0)])
    (vector-set! dp 0 1)
    (for ([i (in-range 1 (add1 n))])
      (if (and (>= i min-length) (is-prime (string-ref s 0))
          (vector-set! prefix i (vector-ref dp (- i min-length)))
          (vector-set! prefix i (modulo (+ (vector-ref prefix (- i 1)) (vector-ref prefix i)) MOD)))
    (for ([j (in-range 1 (add1 k))])
      (let ([current (make-vector (add1 n) 0)])
        (for ([i (in-range 1 (add1 n))])
          (if (not (is-prime (string-ref s (- i 1))))
              (vector-set! current i (modulo (+ (vector-ref current (- i 1)) (vector-ref prefix i)) MOD))
              (vector-set! current i (vector-ref current (- i 1)))))
        (set! dp current)
        (fill! prefix 0)
        (for ([i (in-range 1 (add1 n))])
          (if (>= i min-length)
              (vector-set! prefix i (vector-ref dp (- i min-length)))
              (vector-set! prefix i 0))
          (vector-set! prefix i (modulo (+ (vector-ref prefix (- i 1)) (vector-ref prefix i)) MOD)))))
    (vector-ref dp n)))