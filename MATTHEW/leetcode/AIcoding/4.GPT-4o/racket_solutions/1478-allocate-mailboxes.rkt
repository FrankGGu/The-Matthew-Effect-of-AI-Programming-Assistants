(define (minDistance houses k)
  (define (cost houses)
    (define n (length houses))
    (define median (list-ref houses (quotient n 2)))
    (apply + (map (lambda (h) (abs (- h median))) houses)))

  (define (dp i k)
    (if (zero? k)
        (if (zero? i) 0 +inf.0)
        (if (zero? i) +inf.0
            (let loop ((j i) (best +inf.0))
              (if (>= j 0)
                  (loop (sub1 j) (min best (+ (cost (sublist houses j i)) (dp j (sub1 k)))))
                  best)))))

  (let ((houses (sort houses <)))
    (dp (length houses) k)))

(define (allocateMailboxes houses k)
  (minDistance houses k))