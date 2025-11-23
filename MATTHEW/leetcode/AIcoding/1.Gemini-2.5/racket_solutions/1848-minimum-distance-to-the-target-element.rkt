(define (get-min-distance nums target start)
  (let* ([n (length nums)]
         [min-dist (+ n 1)])
    (for ([i (in-range n)])
      (when (= (list-ref nums i) target)
        (set! min-dist (min min-dist (abs (- i start))))))
    min-dist))