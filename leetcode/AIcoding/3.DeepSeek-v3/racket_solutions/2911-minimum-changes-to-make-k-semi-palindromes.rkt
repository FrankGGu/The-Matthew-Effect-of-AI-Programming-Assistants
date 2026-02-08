#lang racket

(define (minimum-changes-to-make-k-semi-palindromes s k)
  (define n (string-length s))
  (define dp (make-vector (add1 k) (make-vector (add1 n) +inf.0)))
  (vector-set! (vector-ref dp 0) 0 0)

  (define (cost l r)
    (define len (- r l))
    (define divisors (filter (λ (d) (and (> d 1) (zero? (modulo len d)))) (range 1 (add1 (quotient len 2)))))
    (if (null? divisors)
        0
        (for/fold ([min-cost +inf.0]) ([d (in-list divisors)])
            (define total 0)
            (for ([i (in-range d)])
                (define cnt (make-hash))
                (for ([j (in-range i len d)])
                    (define c (string-ref s (+ l j)))
                    (hash-update! cnt c add1 0))
                (define max-freq (apply max (hash-values cnt)))
                (set! total (+ total (- (quotient len d) max-freq))))
            (min min-cost total))))

  (for ([i (in-range 1 (add1 k))])
    (for ([j (in-range 1 (add1 n))])
      (for ([p (in-range (sub1 j) -1 -1)])
        (define c (cost p j))
        (define val (+ (vector-ref (vector-ref dp (sub1 i)) p) c))
        (when (< val (vector-ref (vector-ref dp i) j))
          (vector-set! (vector-ref dp i) j val)))))

  (define result (vector-ref (vector-ref dp k) n))
  (if (= result +inf.0) -1 result))