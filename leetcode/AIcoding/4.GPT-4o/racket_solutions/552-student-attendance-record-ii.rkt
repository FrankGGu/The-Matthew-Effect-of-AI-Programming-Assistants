(define (checkRecord n)
  (define mod 1000000007)
  (define dp (make-vector (+ n 1) 0))
  (define dp-a (make-vector (+ n 1) 0))
  (define dp-l (make-vector (+ n 1) 0))

  (vector-set! dp 0 1)
  (vector-set! dp-a 0 1)
  (vector-set! dp-l 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp i (modulo (+ (vector-ref dp (- i 1)) (vector-ref dp-a (- i 1)) (vector-ref dp-l (- i 1))) mod))
    (vector-set! dp-a i (modulo (vector-ref dp (- i 1)) mod))
    (vector-set! dp-l i (modulo (+ (vector-ref dp (- i 1)) (vector-ref dp-l (- i 1))) mod)))

  (define total (vector-ref dp n))
  (for ([i (in-range 1 (+ n 1))])
    (vector-set! dp-l i (modulo (+ (vector-ref dp-l i) (vector-ref dp-a i)) mod)))

  (define result total)
  (for ([i (in-range 1 (+ n 1))])
    (define temp (modulo (* (vector-ref dp-l i) (vector-ref dp (- n i))) mod))
    (set! result (modulo (+ result temp) mod)))

  result)

(checkRecord 2)