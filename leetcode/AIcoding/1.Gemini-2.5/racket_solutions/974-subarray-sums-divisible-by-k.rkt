(define (subarrays-div-by-k nums k)
  (let* ([remainder-counts (make-vector k 0)]
         [current-sum 0]
         [total-count 0])

    (vector-set! remainder-counts 0 1)

    (for ([num (in-list nums)])
      (set! current-sum (+ current-sum num))

      (let ([remainder (modulo current-sum k)])
        (set! total-count (+ total-count (vector-ref remainder-counts remainder)))
        (vector-set! remainder-counts remainder (+ (vector-ref remainder-counts remainder) 1))))

    total-count))