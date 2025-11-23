(define (best-team-with-no-conflicts ages scores)
  (define (compare a b)
    (if (< (car a) (car b))
        -1
        (if (> (car a) (car b))
            1
            (if (< (cadr a) (cadr b))
                -1
                1))))
  (define sorted (sort (map vector ages scores) compare))
  (define n (length sorted))
  (define dp (make-vector n 0))
  (for ([i (in-range n)])
    (vector-set! dp i (vector-ref sorted i 1))
    (for ([j (in-range i)])
      (when (<= (vector-ref sorted j 1) (vector-ref sorted i 1))
        (vector-set! dp i (max (vector-ref dp i) (+ (vector-ref dp j) (vector-ref sorted i 1))))))
  (apply max (vector->list dp)))