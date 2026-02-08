(define (is-one-bit-character bits)
  (let ((n (vector-length bits)))
    (define (traverse i)
      (cond
        ((= i (- n 1))
         #t)
        ((>= i n)
         #f)
        ((zero? (vector-ref bits i))
         (traverse (+ i 1)))
        (else
         (traverse (+ i 2)))))
    (traverse 0)))