(define (job-scheduling start-time end-time profit)
  (define n (length start-time))

  (when (= n 0)
    (list 0))

  (define jobs
    (for/list ([s (in-list start-time)]
               [e (in-list end-time)]
               [p (in-list profit)])
      (list s e p)))

  (define sorted-jobs
    (vector-sort (lambda (j1 j2) (< (second j1) (second j2)))
                 (list->vector jobs)))

  (define dp (make-vector n 0))

  (define (find-previous-job-index target-time high-index-exclusive)
    (define low 0)
    (define high (- high-index-exclusive 1))
    (define ans -1)
    (while (<= low high)
      (define mid (+ low (quotient (- high low) 2)))
      (define job-at-mid (vector-ref sorted-jobs mid))
      (define mid-end-time (second job-at-mid))
      (if (<= mid-end-time target-time)
          (begin
            (set! ans mid)
            (set! low (+ mid 1)))
          (set! high (- mid 1))))
    ans)

  (for ([i (in-range n)])
    (define current-job (vector-ref sorted-jobs i))
    (define current-start (first current-job))
    (define current-profit (third current-job))

    (define exclude-profit (if (> i 0) (vector-ref dp (- i 1)) 0))

    (define include-profit current-profit)
    (define prev-job-idx (find-previous-job-index current-start i))
    (when (>= prev-job-idx 0)
      (set! include-profit (+ include-profit (vector-ref dp prev-job-idx))))

    (vector-set! dp i (max exclude-profit include-profit)))

  (if (> n 0) (vector-ref dp (- n 1)) 0))