(define (get-averages nums k)
  (define n (length nums))
  (define averages (make-vector n -1))
  (define window-sum 0)

  (for ([i (in-range n)])
    (cond
      [(< i k)
       (set! window-sum (+ window-sum (list-ref nums i)))]
      [(= i k)
       (set! window-sum (+ window-sum (list-ref nums i)))
       (vector-set! averages i (floor (/ window-sum (+ (* 2 k) 1))))]
      [else
       (set! window-sum (+ window-sum (list-ref nums i)))
       (set! window-sum (- window-sum (list-ref nums (- i (* 2 k) 1))))
       (vector-set! averages i (floor (/ window-sum (+ (* 2 k) 1))))]))

  (for ([i (in-range k)])
    (vector-set! averages i -1)
    (vector-set! averages (- n i 1) -1))

  (vector->list averages))