#lang racket

(define (max-removals source target remove-cost)
  (define len-source (string-length source))
  (define len-target (string-length target))
  (define dp (make-vector (+ len-source 1) 0))
  (for ([i (in-range 1 (+ len-source 1))])
    (vector-set! dp i -inf.0))
  (for ([i (in-range 1 (+ len-source 1))])
    (when (and (>= i (string-length target)) (equal? (substring source (- i (string-length target)) i) target))
      (vector-set! dp i (max (vector-ref dp i) (vector-ref dp (- i (string-length target))) (vector-ref dp (- i (string-length target))) + (vector-ref remove-cost 0))))
    (for ([j (in-range 1 (min i (string-length target)))]
          #:when (equal? (substring source (- i j) i) (substring target (- len-target j) len-target)))
      (vector-set! dp i (max (vector-ref dp i) (vector-ref dp (- i j)) (vector-ref dp (- i j)) + (vector-ref remove-cost j)))))
  (if (negative? (vector-ref dp len-source)) -1 (vector-ref dp len-source)))