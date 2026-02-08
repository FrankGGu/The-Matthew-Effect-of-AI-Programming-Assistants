(define (create-sorted-array instructions)
  (define MODULO 1000000007)
  (define n (length instructions))
  (define sorted (make-vector n 0))
  (define inv (lambda (x) (if (= x 0) 0 (- MODULO x))))

  (define (count-smaller-than x)
    (let loop ((low 0) (high n))
      (if (>= low high)
          low
          (let ((mid (quotient (+ low high) 2)))
            (if (< (vector-ref sorted mid) x)
                (loop (+ mid 1) high)
                (loop low mid))))))

  (define (count_greater_than x)
    (let loop ((low 0) (high n))
      (if (>= low high)
          0
          (let ((mid (quotient (+ low high) 2)))
            (if (<= (vector-ref sorted mid) x)
                (loop (+ mid 1) high)
                (loop low mid))))))

  (define total 0)

  (for ((i (in-range n)))
    (let ((x (vector-ref instructions i)))
      (define less (count-smaller-than x))
      (define greater (count_greater_than x))
      (set! total (modulo (+ total (modulo greater MODULO)) MODULO))
      (vector-set! sorted i x)))

  total)