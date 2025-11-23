#lang racket

(define (ideal-arrays n maxValue)
  (define MOD 1000000007)
  (define maxK (integer-length maxValue))

  (define (comb n k)
    (if (or (< k 0) (> k n)) 0
        (let loop ([i 1] [res 1] [j n])
          (if (> i k) res
              (loop (add1 i) (modulo (* res (quotient j i)) MOD) (sub1 j))))))

  (define dp (make-hash))

  (define (dfs val)
    (hash-ref! dp val
               (lambda ()
                 (let loop ([i 2] [res 1])
                   (if (> i val) res
                       (loop (add1 i)
                             (modulo (+ res (if (zero? (modulo val i))
                                               (dfs (quotient val i))
                                               0))
                                     MOD))))))))

  (let loop ([i 1] [res 0])
    (if (> i maxValue) res
        (loop (add1 i)
              (modulo (+ res (modulo (* (comb (sub1 n) (sub1 (dfs i))) MOD)) MOD)))))