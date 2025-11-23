#lang racket

(define (sum-scores s)
  (define n (string-length s))
  (define lps (make-vector n 0))
  (define (compute-lps)
    (let loop ((i 1) (j 0))
      (when (< i n)
        (cond
          [(char=? (string-ref s i) (string-ref s j))
           (vector-set! lps i j)
           (loop (+ i 1) (+ j 1))]
          [(> j 0) (loop i (vector-ref lps (- j 1)))]
          [else (loop (+ i 1) 0)]))))
  (compute-lps)
  (apply + (vector->list lps)))

(define (main)
  (define input (read-line))
  (printf "~a\n" (sum-scores input)))

(main)