(define (make-k-subarray-sums-equal arr k)
  (define n (length arr))
  (define arr-vec (list->vector arr))
  (define total-operations 0)

  (for ([j (in-range k)])
    (define group-elements '())
    (for ([i (in-range j n k)])
      (set! group-elements (cons (vector-ref arr-vec i) group-elements)))

    (unless (empty? group-elements)
      (define freq-map (make-hash))
      (for-each (lambda (x)
                  (hash-update! freq-map x (lambda (v) (add1 (or v 0))) 0))
                group-elements)

      (define max-freq (apply max (hash-values freq-map)))

      (set! total-operations (+ total-operations (- (length group-elements) max-freq)))))

  total-operations)