#lang racket

(define (longest-repeating-substring s)
  (define n (string-length s))
  (define max-len 0)
  (define start 0)
  (define last (make-hash))
  (for ([i (in-range n)])
    (when (hash-has-key? last (string-ref s i))
      (set! start (max start (add1 (hash-ref last (string-ref s i)))))
    (hash-set! last (string-ref s i) i)
    (set! max-len (max max-len (- i start 1))))
  max-len)