(define (find-peaks arr)
  (let* ((n (length arr))
         (result '()))
    (cond
      [(< n 3) result]
      [else
       (for/list ((i (in-range 1 (- n 1))))
         (when (and (> (list-ref arr i) (list-ref arr (- i 1)))
                    (> (list-ref arr i) (list-ref arr (+ i 1))))
           i))])))