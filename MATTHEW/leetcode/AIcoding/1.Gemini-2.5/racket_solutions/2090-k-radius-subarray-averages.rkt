(define (get-averages nums k)
  (define n (length nums))
  (define nums-vec (list->vector nums))
  (define res-vec (make-vector n -1))
  (define window-size (+ (* 2 k) 1))

  (when (= k 0)
    (for ([i (in-range n)])
      (vector-set! res-vec i (vector-ref nums-vec i))))

  (when (and (> k 0) (<= window-size n))
    (define initial-sum
      (for/sum ([j (in-range window-size)])
        (vector-ref nums-vec j)))

    (vector-set! res-vec k (quotient initial-sum window-size))

    (let loop ((current-idx (+ k 1))
               (current-sum initial-sum))
      (when (<= current-idx (- n k))
        (define prev-element (vector-ref nums-vec (- current-idx k 1)))
        (define next-element (vector-ref nums-vec (+ current-idx k)))

        (define new-sum (- (+ current-sum next-element) prev-element))

        (vector-set! res-vec current-idx (quotient new-sum window-size))

        (loop (+ current-idx 1) new-sum))))

  (vector->list res-vec))