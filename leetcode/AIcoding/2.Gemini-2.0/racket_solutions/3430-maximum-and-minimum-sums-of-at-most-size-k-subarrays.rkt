(define (max-and-min-sums nums k)
  (define n (length nums))
  (define max-sum (make-vector n 0))
  (define min-sum (make-vector n 0))

  (define (calculate-max-min-sums)
    (for ([i (in-range n)])
      (let loop ([j i] [curr-sum 0] [curr-max #f] [curr-min #f])
        (cond
          [(> (- j i) k)
           (vector-set! max-sum i (if (equal? curr-max #f) 0 curr-max))
           (vector-set! min-sum i (if (equal? curr-min #f) 0 curr-min))]
          [(>= j n)
           (vector-set! max-sum i (if (equal? curr-max #f) 0 curr-max))
           (vector-set! min-sum i (if (equal? curr-min #f) 0 curr-min))]
          [else
           (let ([new-sum (+ curr-sum (list-ref nums j))])
             (loop (+ j 1) new-sum
                   (if (or (equal? curr-max #f) (> new-sum curr-max)) new-sum curr-max)
                   (if (or (equal? curr-min #f) (< new-sum curr-min)) new-sum curr-min)))]))))

  (calculate-max-min-sums)

  (define total-max-sum (apply + (vector->list max-sum)))
  (define total-min-sum (apply + (vector->list min-sum)))

  (list total-max-sum total-min-sum))