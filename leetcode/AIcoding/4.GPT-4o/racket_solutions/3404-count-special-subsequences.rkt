(define (count-special-subsequences nums)
  (define mod 1000000007)
  (define n (length nums))
  (define dp (make-vector (add1 n) 0))
  (define count (make-vector 3 0))

  (vector-set! dp 0 1)

  (for ([i (in-range 1 (add1 n))])
    (define x (vector-ref nums (sub1 i)))
    (cond
      [(= x 0)
       (vector-set! dp i (modulo (+ (vector-ref dp (sub1 i)) (vector-ref dp (sub1 i))) mod))]
      [(= x 1)
       (vector-set! dp i (modulo (vector-ref dp (sub1 i)) mod))]
      [(= x 2)
       (vector-set! dp i (modulo (+ (vector-ref dp (sub1 i)) (vector-ref dp (sub1 i))) mod))]))

    (if (or (= x 0) (= x 1))
        (vector-set! count (if (= x 0) 0 1) (add1 (vector-ref count (if (= x 0) 0 1)))))
    (if (= x 2)
        (vector-set! count 2 (add1 (vector-ref count 2)))))

  (define total 0)
  (for ([i (in-range 3)])
    (set! total (modulo (+ total (vector-ref count i)) mod)))

  (modulo (- (vector-ref dp n) total) mod))

(count-special-subsequences '(0 1 2 0 1 2))