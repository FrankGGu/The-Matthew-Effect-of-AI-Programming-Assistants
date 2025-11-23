#lang racket

(define (num-of-arrays n m k)
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) (make-vector (+ m 1) (make-vector (+ k 1) 0))))
  (define prefix (make-vector (+ n 1) (make-vector (+ m 1) (make-vector (+ k 1) 0))))

  (for ([j (in-range 1 (+ m 1))])
    (vector-set! (vector-ref dp 1) j 1)
    (vector-set! (vector-ref prefix 1) j 1))

  (for ([i (in-range 2 (+ n 1))])
    (for ([j (in-range 1 (+ m 1))])
      (for ([l (in-range 1 (+ k 1))])
        (define val (vector-ref (vector-ref (vector-ref dp (- i 1)) j) l))
        (set! val (modulo (* j val) mod))
        (when (and (>= l 1) (>= j 1))
          (set! val (modulo (+ val (vector-ref (vector-ref (vector-ref prefix (- i 1)) (- j 1)) (- l 1))) mod))
        (vector-set! (vector-ref (vector-ref dp i) j) l val)
        (define prefix-val (vector-ref (vector-ref (vector-ref prefix i) (- j 1)) l))
        (set! prefix-val (modulo (+ prefix-val val) mod))
        (vector-set! (vector-ref (vector-ref prefix i) j) l prefix-val))))

  (vector-ref (vector-ref (vector-ref prefix n) m) k))