(define (minKBitFlips A K)
  (define n (vector-length A))
  (define flip-count 0)
  (define flips (make-vector n 0))
  (define current-flips 0)

  (for ([i (in-range n)])
    (when (> i 0)
      (set! current-flips (- current-flips (vector-ref flips (- i 1))))
      )

    (define is-flipped? (odd? current-flips))
    (define current-value (vector-ref A i))

    (when (and (not is-flipped?) (= current-value 0))
      (cond
        [(>= i (- n K))
         (return -1)]
        [else
         (set! flip-count (+ flip-count 1))
         (set! current-flips (+ current-flips 1))
         (when (< (+ i K) n)
           (vector-set! flips (+ i K) 1))
         ])))

    (when (and is-flipped? (= current-value 1))
      (cond
        [(>= i (- n K))
         (return -1)]
        [else
         (set! flip-count (+ flip-count 1))
         (set! current-flips (+ current-flips 1))
         (when (< (+ i K) n)
           (vector-set! flips (+ i K) 1))
         ])))

  flip-count)