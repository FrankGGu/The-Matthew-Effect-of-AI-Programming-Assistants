(define (is-self-crossing distances)
  (let* ([n (length distances)]
         [ds (list->vector distances)])
    (if (< n 4)
        #f
        (let loop ([i 3])
          (cond
            [(>= i n) #f]
            [else
             (let ([d_i (vector-ref ds i)]
                   [d_i-1 (vector-ref ds (- i 1))]
                   [d_i-2 (vector-ref ds (- i 2))]
                   [d_i-3 (vector-ref ds (- i 3))])

               (or
                (and (>= d_i d_i-2)
                     (>= d_i-1 d_i-3))

                (and (>= i 4)
                     (let ([d_i-4 (vector-ref ds (- i 4))])
                       (and (= d_i-1 d_i-3)
                            (>= (+ d_i d_i-4) d_i-2))))

                (and (>= i 5)
                     (let ([d_i-4 (vector-ref ds (- i 4))]
                           [d_i-5 (vector-ref ds (- i 5))])
                       (and (>= d_i-2 d_i-4)
                            (>= d_i-1 (- d_i-3 d_i-5))
                            (>= (+ d_i d_i-4) d_i-2))))

                (loop (+ i 1)))))]))))