(define (max-two-events events)
  (let* ([sorted-events (sort events (lambda (a b) (< (car a) (car b))))]
         [n (length sorted-events)]
         [max-so-far (make-vector n 0)])
    (vector-set! max-so-far (- n 1) (caddr (list-ref sorted-events (- n 1))))
    (for ([i (in-range (- n 2) -1 -1)])
      (vector-set! max-so-far i (max (vector-ref max-so-far (+ i 1)) (caddr (list-ref sorted-events i)))))
    (let loop ([i 0]
               [max-sum 0])
      (if (>= i n)
          max-sum
          (let ([current-val (caddr (list-ref sorted-events i))]
                [start (car (list-ref sorted-events i))]
                [end (cadr (list-ref sorted-events i))])
            (let ([low (+ i 1)]
                  [high (- n 1)]
                  [next-index n])
              (let binary-search ([low low]
                                  [high high])
                (if (<= low high)
                    (let* ([mid (quotient (+ low high) 2)]
                           [mid-start (car (list-ref sorted-events mid))])
                      (if (> mid-start end)
                          (begin
                            (set! next-index mid)
                            (binary-search low (- mid 1)))
                          (binary-search (+ mid 1) high)))
                    (void)))
              (let ([current-max current-val])
                (if (< next-index n)
                    (set! current-max (+ current-max (vector-ref max-so-far next-index)))
                    (void))
                (loop (+ i 1) (max max-sum current-max))))))))