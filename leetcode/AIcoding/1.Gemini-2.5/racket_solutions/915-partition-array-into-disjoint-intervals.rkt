(define (partition-disjoint nums)
  (define n (vector-length nums))

  (define max-left (vector-ref nums 0))
  (define overall-max (vector-ref nums 0))
  (define partition-len 1)

  (for ([i (in-range 1 n)])
    (define current-num (vector-ref nums i))
    (set! overall-max (max overall-max current-num))
    (when (< current-num max-left)
      (set! partition-len (+ i 1))
      (set! max-left overall-max)))

  partition-len)