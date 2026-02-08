(define (count-primes n)
  (if (<= n 2)
      0
      (let* ([is-prime (make-vector n #t)]
             [prime-count 0])
        (vector-set! is-prime 0 #f)
        (vector-set! is-prime 1 #f)

        (for ([p (in-range 2 (+ (floor (sqrt n)) 1))])
          (when (vector-ref is-prime p)
            (for ([i (in-range (* p p) n p)])
              (vector-set! is-prime i #f))))

        (for ([i (in-range 2 n)])
          (when (vector-ref is-prime i)
            (set! prime-count (+ prime-count 1))))
        prime-count)))