(define (most-points questions)
  (let* ((n (length questions))
         (dp (make-vector (+ n 1) 0))) ; dp[i] stores max points from question i onwards. dp[n] = 0.
    (for ((i (range (- n 1) -1 -1))) ; Iterate from n-1 down to 0
      (let* ((q (list-ref questions i))
             (points (car q))
             (brainpower (cadr q)))

        (let ((solve-current-points points))
          (let ((next-idx-after-solve (+ i brainpower 1)))
            (when (< next-idx-after-solve n) ; If next question index after solving is within bounds
              (set! solve-current-points (+ solve-current-points (vector-ref dp next-idx-after-solve))))
            ; If next-idx-after-solve is n or greater, dp[next-idx-after-solve] is effectively 0,
            ; which is handled by the initial value of solve-current-points being just 'points'.

            (let ((skip-current-points (vector-ref dp (+ i 1))))
              (vector-set! dp i (max solve-current-points skip-current-points)))))))
    (vector-ref dp 0)))