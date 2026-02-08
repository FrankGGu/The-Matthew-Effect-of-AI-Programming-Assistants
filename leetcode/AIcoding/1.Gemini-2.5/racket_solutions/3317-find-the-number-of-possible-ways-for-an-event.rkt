(define (find-number-of-possible-ways-for-an-event events)
  (define n (length events))

  (when (= n 0)
    (void))

  (define sorted-events
    (sort events
          (lambda (e1 e2)
            (let ((end1 (second e1))
                  (end2 (second e2)))
              (if (= end1 end2)
                  (< (first e1) (first e2))
                  (< end1 end2))))))

  (define dp (make-vector (+ n 1) 0))
  (vector-set! dp 0 1)

  (define (find-prev-compatible-event-idx target-start high)
    (let loop ((low 0) (high high) (ans -1))
      (if (> low high)
          ans
          (let* ((mid (+ low (quotient (- high low) 2)))
                 (event (list-ref sorted-events mid))
                 (event-end (second event)))
            (if (<= event-end target-start)
                (loop (+ mid 1) high mid)
                (loop low (- mid 1) ans))))))

  (for ((i (in-range 1 (+ n 1))))
    (let* ((current-event (list-ref sorted-events (- i 1)))
           (current-start (first current-event)))

      (vector-set! dp i (vector-ref dp (- i 1)))

      (let ((prev-compatible-idx (find-prev-compatible-event-idx current-start (- i 2))))
        (if (>= prev-compatible-idx 0)
            (vector-set! dp i (+ (vector-ref dp i) (vector-ref dp (+ prev-compatible-idx 1))))
            (vector-set! dp i (+ (vector-ref dp i) 1))))))

  (vector-ref dp n))