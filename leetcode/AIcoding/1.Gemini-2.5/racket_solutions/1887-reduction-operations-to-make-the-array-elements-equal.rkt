(define (reduction-operations nums)
  (let* ([sorted-nums-list (sort nums <)]
         [n (length sorted-nums-list)])
    (if (<= n 1)
        0
        (let ([sorted-nums (list->vector sorted-nums-list)])
          (for/fold ([operations 0]
                     [distinct-steps 0])
                    ([i (in-range 1 n)])
            (let* ([current-val (vector-ref sorted-nums i)]
                   [prev-val (vector-ref sorted-nums (- i 1))])
              (if (> current-val prev-val)
                  (values (+ operations (+ distinct-steps 1))
                          (+ distinct-steps 1))
                  (values (+ operations distinct-steps)
                          distinct-steps))))))))