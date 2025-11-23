(define (max-two-events events)
  (define sorted-events (sort events < #:key car))
  (define n (length sorted-events))
  (define max-val (make-vector n 0))

  (vector-set! max-val (- n 1) (list-ref (list-ref sorted-events (- n 1)) 2))
  (for ((i (in-range (- n 2) -1 -1)))
    (vector-set! max-val i (max (list-ref (list-ref sorted-events i) 2) (vector-ref max-val (+ i 1)))))

  (define (find-next-non-overlapping event)
    (define end (list-ref event 1))
    (define (binary-search low high)
      (cond
        ((> low high) low)
        (else
         (define mid (floor (/ (+ low high) 2)))
         (if (>= (list-ref (list-ref sorted-events mid) 0) end)
             (binary-search low (- mid 1))
             (binary-search (+ mid 1) high)))))
    (binary-search 0 (- n 1)))

  (define ans 0)
  (for ((i (in-range n)))
    (define current-event (list-ref sorted-events i))
    (define next-index (find-next-non-overlapping current-event))
    (define current-val (list-ref current-event 2))
    (define next-val (if (= next-index n) 0 (vector-ref max-val next-index)))
    (set! ans (max ans (+ current-val next-val))))

  ans)