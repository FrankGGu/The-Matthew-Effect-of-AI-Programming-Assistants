#lang racket

(define (minimum-number-of-valid-strings-to-form-target-i strs target)
  (define n (string-length target))
  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (for ([s strs])
      (define s-len (string-length s))
      (when (<= s-len i)
        (define prev-idx (- i s-len))
        (when (>= prev-idx 0)
          (define sub-target (substring target prev-idx i))
          (when (string=? sub-target s)
            (define prev-val (vector-ref dp prev-idx))
            (when (not (eq? prev-val +inf.0))
              (vector-set! dp i (min (vector-ref dp i) (+ prev-val 1)))))))))

  (define result (vector-ref dp n))
  (if (eq? result +inf.0)
      -1
      result))