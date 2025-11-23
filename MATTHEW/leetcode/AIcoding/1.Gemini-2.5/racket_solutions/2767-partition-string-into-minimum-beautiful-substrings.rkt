#lang racket

(define (minimum-beautiful-substrings s)
  (define n (string-length s))

  (define powers-of-5
    (set 1 5 25 125 625 3125 15625))

  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range i)])
      (when (not (equal? (vector-ref dp j) +inf.0))
        (define sub-str (substring s j i))
        (when (char=? (string-ref sub-str 0) #\1)
          (define val (string->number sub-str 2))
          (when (set-member? powers-of-5 val)
            (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) 1))))))))

  (define result (vector-ref dp n))
  (if (equal? result +inf.0)
      -1
      result))