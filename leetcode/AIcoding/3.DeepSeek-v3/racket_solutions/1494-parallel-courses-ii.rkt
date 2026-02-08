#lang racket

(define (min-number-of-semesters n relations k)
  (define pre (make-vector n 0))
  (for ([rel relations])
    (let ([u (sub1 (first rel))]
          [v (sub1 (second rel))])
      (vector-set! pre v (bitwise-ior (vector-ref pre v) (arithmetic-shift 1 u)))))

  (define dp (make-vector (arithmetic-shift 1 n) +inf.0))
  (vector-set! dp 0 0)

  (for ([mask (in-range (arithmetic-shift 1 n))])
    (when (< (vector-ref dp mask) +inf.0)
      (define available 0)
      (for ([i (in-range n)])
        (when (and (zero? (bitwise-and (vector-ref pre i) (bitwise-not mask)))
              (bitwise-and (arithmetic-shift 1 i) (bitwise-not mask)))
          (set! available (bitwise-ior available (arithmetic-shift 1 i)))))
      (define candidates available)
      (when (> (bit-count candidates) k)
        (set! candidates (bitwise-and candidates (sub1 (arithmetic-shift 1 k)))))
      (let loop ([subset candidates])
        (when (not (zero? subset))
          (when (<= (bit-count subset) k)
            (let ([new-mask (bitwise-ior mask subset)])
              (when (> (vector-ref dp new-mask) (add1 (vector-ref dp mask)))
                (vector-set! dp new-mask (add1 (vector-ref dp mask))))))
          (loop (bitwise-and subset (sub1 subset))))))

  (vector-ref dp (sub1 (arithmetic-shift 1 n))))

(define (bit-count x)
  (if (zero? x) 0 (+ (bitwise-and x 1) (bit-count (arithmetic-shift x -1)))))