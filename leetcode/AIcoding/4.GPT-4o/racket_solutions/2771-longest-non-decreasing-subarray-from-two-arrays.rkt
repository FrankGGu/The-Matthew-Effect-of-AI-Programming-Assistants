(define (maxNonDecreasingLength A B)
  (define n (length A))
  (define max-length 0)
  (define current-length 1)

  (define (check i)
    (when (<= (vector-ref A i) (vector-ref A (+ i 1)))
      (set! current-length (+ current-length 1))
      (set! max-length (max max-length current-length)))
    (when (<= (vector-ref B i) (vector-ref B (+ i 1)))
      (set! current-length (+ current-length 1))
      (set! max-length (max max-length current-length)))
    (set! current-length 1))

  (for ([i (in-range (- n 1))])
    (check i))

  max-length)

(maxNonDecreasingLength #(1 3 2 4) #(2 4 3 5))