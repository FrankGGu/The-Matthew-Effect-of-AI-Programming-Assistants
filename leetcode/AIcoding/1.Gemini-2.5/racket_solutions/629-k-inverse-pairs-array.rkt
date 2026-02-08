(define (k-inverse-pairs n k)
  (define MOD 1000000007)

  (define dp-prev (make-vector (+ k 1) 0))
  (vector-set! dp-prev 0 1)

  (for ([i (in-range 1 (+ n 1))])
    (define dp-curr (make-vector (+ k 1) 0))
    (define current-sum 0)
    (for ([j (in-range 0 (+ k 1))])
      (set! current-sum (+ current-sum (vector-ref dp-prev j)))
      (set! current-sum (modulo current-sum MOD))

      (when (>= j i)
        (set! current-sum (- current-sum (vector-ref dp-prev (- j i))))
        (set! current-sum (modulo (+ current-sum MOD) MOD)))

      (vector-set! dp-curr j current-sum))
    (set! dp-prev dp-curr))

  (vector-ref dp-prev k))