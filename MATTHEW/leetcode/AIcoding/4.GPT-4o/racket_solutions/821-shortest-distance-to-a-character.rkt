(define (shortestToChar s c)
  (define n (string-length s))
  (define distances (make-vector n (sub1 n)))
  (define last-pos -1)

  (for ([i (in-range n)])
    (if (equal? (string-ref s i) c)
        (begin
          (set! last-pos i)
          (vector-set! distances i 0)
          (for ([j (in-range (add1 i) n)])
            (if (equal? (string-ref s j) c)
                (set! last-pos j)
                (vector-set! distances j (min (vector-ref distances j) (abs (- j last-pos)))))))
        (if (and (>= last-pos 0) (< last-pos i))
            (vector-set! distances i (abs (- i last-pos))))))

  (set! last-pos -1)

  (for ([i (in-range (sub1 n) -1 -1)])
    (if (equal? (string-ref s i) c)
        (begin
          (set! last-pos i)
          (for ([j (in-range (sub1 i) -1 -1)])
            (if (equal? (string-ref s j) c)
                (set! last-pos j)
                (vector-set! distances j (min (vector-ref distances j) (abs (- j last-pos)))))))
        (if (and (>= last-pos 0) (> last-pos i))
            (vector-set! distances i (min (vector-ref distances i) (abs (- i last-pos)))))))

  (vector->list distances))