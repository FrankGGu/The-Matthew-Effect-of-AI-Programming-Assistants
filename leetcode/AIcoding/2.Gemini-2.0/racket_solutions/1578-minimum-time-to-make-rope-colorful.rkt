(define (min-cost colors needed-time)
  (let loop ([i 1] [cost 0] [max-time (list-ref needed-time 0)])
    (if (= i (length colors))
        cost
        (let ([curr-color (string->list colors i)]
              [prev-color (string->list colors (- i 1))])
          (if (equal? curr-color prev-color)
              (let ([curr-time (list-ref needed-time i)])
                (if (> max-time curr-time)
                    (loop (+ i 1) (+ cost curr-time) max-time)
                    (loop (+ i 1) (+ cost max-time) curr-time)))
              (loop (+ i 1) cost (list-ref needed-time i)))))))