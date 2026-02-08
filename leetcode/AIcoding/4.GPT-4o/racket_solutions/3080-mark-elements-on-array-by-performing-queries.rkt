(define (markElements arr queries)
  (define n (length arr))
  (define marked (make-vector n #f))

  (for ([q queries])
    (for ([i (in-range n)])
      (when (or (= arr[i] q) (vector-ref marked i))
        (vector-set! marked i #t))))

  (map (λ (x) (if (vector-ref marked x) -1 (arr[x]))) (in-range n)))

(define (arrayChange arr queries)
  (markElements arr queries))