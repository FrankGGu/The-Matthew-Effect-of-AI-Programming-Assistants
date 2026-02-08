(define (maxSatisfaction satisfaction)
  (define n (length satisfaction))
  (define sorted-satisfaction (sort satisfaction <))

  (define (dp idx time)
    (if (>= idx n) 0
        (let ((include (+ (* time (vector-ref sorted-satisfaction idx))
                          (dp (+ idx 1) (+ time 1))))
              (exclude (dp (+ idx 1) time)))
          (max include exclude))))

  (dp 0 0))

(define (maxSatisfaction satisfaction)
  (dp 0 0))

(maxSatisfaction satisfaction)