(define (find-prefix-scores nums)
  (define n (length nums))
  (define prefix-scores (make-vector n 0))
  (define max-prefix (make-vector n 0))

  (for ([i (in-range n)])
    (define current-max (if (zero? i) (vector-ref nums 0) (max (vector-ref max-prefix (- i 1)) (vector-ref nums i))))
    (vector-set! max-prefix i current-max)
    (vector-set! prefix-scores i (+ current-max (if (zero? i) 0 (vector-ref prefix-scores (- i 1))))))
  )

  (vector->list prefix-scores))

(find-prefix-scores '(1 2 3 4)) ; This line is for local testing, remove it before submission.