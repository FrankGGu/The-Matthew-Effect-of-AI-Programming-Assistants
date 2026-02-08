(define (max-k-subarray-sum nums k m)
  (define n (length nums))
  (define prefix-sum (make-vector (+ n 1) 0))
  (for/fold ([i 1]) ([num (in-list nums)])
    (vector-set! prefix-sum i (+ (vector-ref prefix-sum (- i 1)) num))
    (+ i 1))

  (define (calculate-sum i j)
    (- (vector-ref prefix-sum (+ j 1)) (vector-ref prefix-sum i)))

  (define (solve start k)
    (if (= k 0)
        0
        (if (> (- n start) m)
            (let loop ([i start] [max-sum -inf.0])
              (if (> i (- n m))
                  max-sum
                  (let ([curr-sum (calculate-sum i (+ i m -1))])
                    (let ([remaining-max (solve (+ i m) (- k 1))])
                      (loop (+ i 1) (max max-sum (+ curr-sum remaining-max)))))))
            -inf.0)))

  (let ([result (solve 0 k)])
    (if (equal? result -inf.0) 0 result)))