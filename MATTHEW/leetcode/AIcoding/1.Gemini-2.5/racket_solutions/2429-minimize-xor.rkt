#lang racket

(define (minimize-xor num1 num2)
  (let* ([k (bitwise-popcount num2)]
         [max-bit 29] ; For positive integers up to 10^9, the highest relevant bit index is 29 (2^29 < 10^9 < 2^30)
         [x 0])

    (let-values ([(new-x remaining-k)]
                 (for/fold ([current-x x] [current-k k])
                           ([i (in-range max-bit -1 -1)])
                   (let ([bit-val (expt 2 i)])
                     (if (and (> current-k 0)
                              (not (zero? (bitwise-and num1 bit-val))))
                         (values (bitwise-ior current-x bit-val) (- current-k 1))
                         (values current-x current-k)))))
      (set! x new-x)
      (set! k remaining-k))

    (when (> k 0)
      (let-values ([(new-x remaining-k)]
                   (for/fold ([current-x x] [current-k k])
                             ([i (in-range 0 (add1 max-bit))])
                     (let ([bit-val (expt 2 i)])
                       (if (and (> current-k 0)
                                (zero? (bitwise-and num1 bit-val))
                                (zero? (bitwise-and current-x bit-val)))
                           (values (bitwise-ior current-x bit-val) (- current-k 1))
                           (values current-x current-k)))))
        (set! x new-x)
        (set! k remaining-k)))

    x))