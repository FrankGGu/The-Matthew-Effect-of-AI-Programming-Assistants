(define (minChanges(arr k)
  (define n (length arr))
  (define counts (make-vector k 0))
  (for ([i (in-range n)])
    (vector-set! counts (modulo (vector-ref arr i) k) (+ 1 (vector-ref counts (modulo (vector-ref arr i) k)))))
  (define max-count (apply max (vector->list counts)))
  (- n max-count))

(minChanges '(1 2 3 4 5) 2)