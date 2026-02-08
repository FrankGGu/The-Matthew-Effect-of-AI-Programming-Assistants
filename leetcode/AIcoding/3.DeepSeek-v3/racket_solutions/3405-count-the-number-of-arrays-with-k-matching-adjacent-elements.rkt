#lang racket

(define (numOfArrays n m k)
  (define mod 1000000007)
  (define dp (make-vector (add1 n) (make-vector (add1 m) (make-vector (add1 k) 0))))
  (define prefix (make-vector (add1 n) (make-vector (add1 m) (make-vector (add1 k) 0))))

  (for ([j (in-range 1 (add1 m))])
    (vector-set! (vector-ref dp 1) j 1 (vector-set! (vector-ref (vector-ref dp 1) j) 1 1))
    (vector-set! (vector-ref prefix 1) j 1 (modulo (+ (vector-ref (vector-ref prefix 1) (- j 1) 1) 
                                                  (vector-ref (vector-ref (vector-ref dp 1) j) 1)) mod))

  (for ([i (in-range 2 (add1 n))])
    (for ([max_j (in-range 1 (add1 m))])
      (for ([cost (in-range 1 (add1 k))])
        (define val (modulo (* max_j (vector-ref (vector-ref (vector-ref dp (- i 1)) max_j) cost)) mod))
        (vector-set! (vector-ref dp i) max_j cost (modulo (+ val 
                                                           (vector-ref (vector-ref (vector-ref prefix (- i 1)) (- max_j 1)) (- cost 1))) mod))
        (vector-set! (vector-ref prefix i) max_j cost (modulo (+ (vector-ref (vector-ref (vector-ref prefix i) (- max_j 1)) cost) 
                                                             (vector-ref (vector-ref (vector-ref dp i) max_j) cost)) mod))))

  (define result 0)
  (for ([j (in-range 1 (add1 m))])
    (set! result (modulo (+ result (vector-ref (vector-ref (vector-ref dp n) j) k)) mod)))
  result)