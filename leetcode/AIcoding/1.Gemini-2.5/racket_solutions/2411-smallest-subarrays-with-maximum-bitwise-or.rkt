#lang racket

(define (smallest-subarrays-with-maximum-bitwise-or nums)
  (define n (vector-length nums))

  (define max-or
    (if (zero? n)
        0
        (foldl bitwise-ior 0 (vector->list nums))))

  (when (zero? max-or)
    (if (zero? n)
        '()
        (make-vector n 1)))

  (define rightmost-bit-idx (make-vector 31 -1))

  (define ans (make-vector n))

  (for ([i (range (- n 1) -1 -1)])
    (define current-num (vector-ref nums i))

    (for ([b (range 31)])
      (when (not (zero? (bitwise-and current-num (arithmetic-shift 1 b))))
        (vector-set! rightmost-bit-idx b i)))

    (define target-j -1)
    (for ([b (range 31)])
      (when (not (zero? (bitwise-and max-or (arithmetic-shift 1 b))))
        (set! target-j (max target-j (vector-ref rightmost-bit-idx b)))))

    (vector-set! ans i (+ (- target-j i) 1)))

  (vector->list ans))