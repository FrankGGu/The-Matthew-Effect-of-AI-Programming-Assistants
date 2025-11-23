(define/contract (max-value events k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define n (length events))
  (define sorted-events (sort events (lambda (a b) (< (second a) (second b)))))
  (define dp (make-vector (add1 n) (make-vector (add1 k) 0)))

  (for ([i (in-range 1 (add1 n))])
    (define current-start (first (list-ref sorted-events (sub1 i))))
    (define current-end (second (list-ref sorted-events (sub1 i))))
    (define current-value (third (list-ref sorted-events (sub1 i))))

    (define low 0)
    (define high (sub1 i))
    (define last-non-conflict -1)

    (while (<= low high)
      (define mid (quotient (+ low high) 2))
      (define mid-end (second (list-ref sorted-events mid)))
      (if (< mid-end current-start)
          (begin
            (set! last-non-conflict mid)
            (set! low (add1 mid)))
          (set! high (sub1 mid))))

    (for ([j (in-range 1 (add1 k))])
      (vector-set! (vector-ref dp i) j
                   (max (vector-ref (vector-ref dp (sub1 i)) j)
                        (if (>= last-non-conflict 0)
                            (+ current-value (vector-ref (vector-ref dp (add1 last-non-conflict)) (sub1 j)))
                            current-value)))))

  (vector-ref (vector-ref dp n) k))