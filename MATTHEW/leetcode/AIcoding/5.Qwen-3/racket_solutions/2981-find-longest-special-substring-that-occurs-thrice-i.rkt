#lang racket

(define (maximum-length-substring s)
  (define n (string-length s))
  (define cnt (make-hash))
  (for ([i (in-range n)])
    (for ([j (in-range i n)])
      (define substr (substring s i (add1 j)))
      (hash-update! cnt substr add1 0)))
  (define max-len 0)
  (for ([(k v) (in-hash cnt)])
    (when (>= v 3)
      (set! max-len (max max-len (string-length k)))))
  max-len)