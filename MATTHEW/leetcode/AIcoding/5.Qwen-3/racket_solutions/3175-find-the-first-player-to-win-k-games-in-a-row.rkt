(define (can-win? games k)
  (let loop ((i 0) (count 0))
    (if (>= i (length games))
        #f
        (if (= (list-ref games i) 1)
            (if (>= (add1 count) k)
                #t
                (loop (add1 i) (add1 count)))
            (loop (add1 i) 0)))))

(define (k-consecutive-ones games k)
  (let loop ((i 0) (count 0))
    (if (>= i (length games))
        -1
        (if (= (list-ref games i) 1)
            (if (>= (add1 count) k)
                i
                (loop (add1 i) (add1 count)))
            (loop (add1 i) 0)))))