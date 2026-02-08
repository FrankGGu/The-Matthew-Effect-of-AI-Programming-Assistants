(define (color-the-grid m n)
  (define mod 1000000007)
  (define (count-ways m n)
    (define dp (make-vector (add1 n) 0))
    (vector-set! dp 0 1)
    (for ([i (in-range 1 (add1 n))])
      (vector-set! dp i (modulo (+ (* 2 (vector-ref dp (- i 1))) (* 1 (vector-ref dp (- i 2)))) mod)))
    (vector-ref dp n))

  (define total-colors (count-ways m n))
  (modulo (* total-colors total-colors) mod))

(color-the-grid m n)