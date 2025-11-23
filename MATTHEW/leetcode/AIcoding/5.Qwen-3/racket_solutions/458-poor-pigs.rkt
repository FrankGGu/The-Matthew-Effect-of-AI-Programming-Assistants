(define (num-pigs eggs buckets)
  (let loop ((t 0))
    (if (>= (expt (+ 1 t) eggs) buckets)
        t
        (loop (+ t 1)))))