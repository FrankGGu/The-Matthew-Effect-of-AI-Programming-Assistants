(define (kthFactor n k)
  (define (factors n)
    (for/list ([i (in-range 1 (+ n 1))] [#:when (= 0 (modulo n i))])
      i))
  (define f (factors n))
  (if (>= (length f) k)
      (list-ref f (- k 1))
      -1))

(kthFactor 12 3) ; Example call