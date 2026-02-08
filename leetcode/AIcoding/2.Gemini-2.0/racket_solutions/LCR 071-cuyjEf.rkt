(define (make-weighted-random-chooser w)
  (let* ([prefix-sums (vector)]
         [total-sum (for/sum ([x (in-list w)]) x)]
         [_ (begin
              (vector-set! prefix-sums 0 (vector-ref w 0))
              (for/fold ([sum (vector-ref w 0)])
                        ([i (in-range 1 (vector-length w))])
                (let ([new-sum (+ sum (vector-ref w i))])
                  (vector-set! prefix-sums i new-sum)
                  new-sum)))])
    (lambda ()
      (let ([target (random total-sum)])
        (let loop ([low 0] [high (- (vector-length w) 1)])
          (if (<= low high)
              (let ([mid (arithmetic-mean low high)])
                (if (<= target (vector-ref prefix-sums mid))
                    (if (zero? mid)
                        mid
                        (if (< target (vector-ref prefix-sums (- mid 1)))
                            mid
                            (- mid 1)))
                    (loop (+ mid 1) high)))
              low))))))

(define W
  (lambda (w)
    (let ([chooser (make-weighted-random-chooser w)])
      (lambda ()
        (chooser)))))