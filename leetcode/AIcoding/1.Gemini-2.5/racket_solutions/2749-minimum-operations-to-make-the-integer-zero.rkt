#lang racket

(define (popcount n)
  (let loop ((count 0) (num n))
    (if (zero? num)
        count
        (loop (+ count (bitwise-and num 1)) (arithmetic-shift num -1)))))

(define (minimum-operations-to-make-the-integer-zero n k)
  (for ((m (in-range 1 65)))
    (let* ((rem (- n (* m k))))
      (when (and (>= rem m) (<= (popcount rem) m))
        (return-from minimum-operations-to-make-the-integer-zero m))))
  -1)