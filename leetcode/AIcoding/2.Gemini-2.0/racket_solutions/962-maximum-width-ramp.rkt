(define (max-width-ramp A)
  (let* ([n (length A)]
         [min-left (make-vector n)])
    (vector-set! min-left 0 (list-ref A 0))
    (for ([i (in-range 1 n)])
      (vector-set! min-left i (min (list-ref A i) (vector-ref min-left (- i 1)))))
    (let loop ([i 0] [j 0] [max-width 0])
      (cond
        [(>= j n) max-width]
        [(>= i n) max-width]
        [else
         (if (<= (vector-ref min-left i) (list-ref A j))
             (loop i (+ j 1) (max max-width (- j i)))
             (loop (+ i 1) j max-width))])))
  )