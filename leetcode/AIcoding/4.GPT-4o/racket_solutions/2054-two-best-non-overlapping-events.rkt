(define (maxTwoEvents events)
  (define sorted-events (sort events (lambda (a b) (< (second a) (second b)))))
  (define max-sum (make-vector (length sorted-events) 0))

  (for ((i (in-range (length sorted-events))))
    (vector-set! max-sum i (if (= i 0)
                               (first (vector-ref sorted-events i))
                               (max (vector-ref max-sum (- i 1))
                                    (first (vector-ref sorted-events i))))))

  (define result 0)

  (for ((i (in-range (length sorted-events))))
    (define current-event (vector-ref sorted-events i))
    (for ((j (in-range i)))
      (when (< (second (vector-ref sorted-events j)) (first current-event))
        (set! result (max result (+ (first current-event) (vector-ref max-sum j))))))

    (set! result (max result (first current-event))))

  result)