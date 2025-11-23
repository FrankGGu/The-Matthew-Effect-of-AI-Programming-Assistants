(define (find-cheapest-price n flights src dst k)
  (define inf +inf.0)
  (define dist (make-vector n inf))
  (vector-set! dist src 0)

  (define (relax u v price)
    (when (< (+ (vector-ref dist u) price) (vector-ref dist v))
      (vector-set! dist v (+ (vector-ref dist u) price))
      #t))

  (define (dijkstra k)
    (define queue (make-vector n '()))
    (vector-set! queue src 0)

    (for ([i (in-range k)]
          [j (in-range (+ 1 k))])
      (define next-queue (make-vector n '()))
      (for ([u (in-range n)])
        (let loop ([v (vector-ref queue u)])
          (when (not (null? v))
            (for ([flight flights])
              (when (equal? (car flight) u)
                (relax u (cadr flight) (caddr flight)))
              (loop (cdr v))))))
      (set! queue next-queue))

    (if (< (vector-ref dist dst) inf)
        (vector-ref dist dst)
        -1))

  (dijkstra k))