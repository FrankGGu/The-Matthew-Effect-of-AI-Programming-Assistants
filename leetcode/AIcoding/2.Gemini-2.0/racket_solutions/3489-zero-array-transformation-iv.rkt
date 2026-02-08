(define (zero-array? arr)
  (andmap zero? arr))

(define (zero-array-transformation arr)
  (let loop ((arr arr) (ops 0))
    (if (zero-array? arr)
        ops
        (let* ((n (length arr))
               (new-arr (make-vector n 0)))
          (for ((i (in-range n)))
            (vector-set! new-arr i (if (zero? (vector-ref arr i))
                                        (vector-ref arr i)
                                        (if (and (< i (- n 1)) (not (zero? (vector-ref arr (+ i 1)))))
                                            0
                                            1))))
          (loop (vector->list new-arr) (+ ops 1))))))