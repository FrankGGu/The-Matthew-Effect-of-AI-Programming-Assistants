(define (longest-arith-seq-length arr difference)
  (define n (length arr))
  (define dp (make-hash))

  (for ([i (in-range n)])
    (define num (list-ref arr i))
    (define prev (- num difference))

    (define prev-len (hash-ref dp prev 0))

    (hash-set! dp num (+ prev-len 1)))

  (foldl (lambda (k v acc) (max acc v)) 0 (hash->list dp)))