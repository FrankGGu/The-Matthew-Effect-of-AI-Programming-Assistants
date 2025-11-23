(define (minimum-total-space-wasted-with-k-resizing-operations nums k)
  (define n (vector-length nums))
  (define +infinity (expt 10 9))

  (define dp (make-vector (+ n 1) #f))
  (for ([i (in-range (+ n 1))])
    (vector-set! dp i (make-vector (+ k 2) +infinity)))

  (vector-set! (vector-ref dp 0) 0 0)

  (for ([j (in-range 1 (+ k 2))])
    (for ([i (in-range 1 (+ n 1))])
      (define current-max 0)
      (define current-sum 0)
      (for ([p-idx (in-range (- i 1) -1 -1)])
        (define file-size (vector-ref nums p-idx))
        (set! current-max (max current-max file-size))
        (set! current-sum (+ current-sum file-size))

        (define segment-length (- i p-idx))
        (define current-waste (- (* segment-length current-max) current-sum))

        (when (< (vector-ref (vector-ref dp p-idx) (- j 1)) +infinity)
          (let ((prev-dp-val (vector-ref (vector-ref dp p-idx) (- j 1))))
            (vector-set! (vector-ref dp i) j
                         (min (vector-ref (vector-ref dp i) j)
                              (+ prev-dp-val current-waste))))))))

  (define min-total-waste +infinity)
  (for ([j (in-range 1 (+ k 2))])
    (set! min-total-waste (min min-total-waste (vector-ref (vector-ref dp n) j))))

  min-total-waste)