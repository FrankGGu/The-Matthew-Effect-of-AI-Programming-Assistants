#lang racket

(define (minimum-cost-to-divide-array-into-subarrays nums k)
  (define n (vector-length nums))

  (define dp (make-vector (+ n 1) +inf.0))
  (vector-set! dp 0 0)

  (define score-memo (make-vector n))
  (for ([j (in-range n)])
    (vector-set! score-memo j (make-vector (+ n 1))))

  (for ([j (in-range n)])
    (define current-freq (make-hash))
    (define current-trim 0)
    (for ([i (in-range (+ j 1) (+ n 1))])
      (define current-element (vector-ref nums (- i 1)))

      (define old-freq (hash-ref current-freq current-element 0))
      (hash-set! current-freq current-element (+ old-freq 1))

      (when (= old-freq 1)
        (set! current-trim (+ current-trim 1)))

      (vector-set! (vector-ref score-memo j) i (+ k current-trim))))

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range i)])
      (define current-score (vector-ref (vector-ref score-memo j) i))
      (vector-set! dp i (min (vector-ref dp i) (+ (vector-ref dp j) current-score)))))

  (vector-ref dp n))