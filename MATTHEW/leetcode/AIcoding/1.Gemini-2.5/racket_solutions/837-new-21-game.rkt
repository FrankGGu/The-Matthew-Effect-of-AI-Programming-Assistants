(define (new21Game N K maxPts)
  (if (>= N (+ K maxPts -1))
      1.0
      (let* ((dp (make-vector (+ N maxPts 1) 0.0))
             (ans 0.0)
             (s 1.0)) ; s is the sum of probabilities of scores (j) such that (i - maxPts) <= j < i and j < K
        (vector-set! dp 0 1.0)

        (for ([i (in-range 1 (+ N maxPts))])
          (vector-set! dp i (/ s maxPts))

          (when (>= i K)
            (when (<= i N)
              (set! ans (+ ans (vector-ref dp i)))))

          (when (< i K)
            (set! s (+ s (vector-ref dp i))))

          (when (>= (- i maxPts) 0)
            (when (< (- i maxPts) K)
              (set! s (- s (vector-ref dp (- i maxPts))))))
        )
        ans)))