(define (max-distance arrays)
  (let loop ([i 1]
             [min-val (car (car arrays))]
             [max-val (car (car arrays))]
             [res 0])
    (if (>= i (length arrays))
        res
        (let* ([current-array (list-ref arrays i)]
               [current-first (car current-array)]
               [current-last (last current-array)]
               [new-res (max res
                            (abs (- current-first max-val))
                            (abs (- current-last min-val)))])
               [new-min-val (min min-val current-first)]
               [new-max-val (max max-val current-last)])
          (loop (add1 i) new-min-val new-max-val new-res)))))