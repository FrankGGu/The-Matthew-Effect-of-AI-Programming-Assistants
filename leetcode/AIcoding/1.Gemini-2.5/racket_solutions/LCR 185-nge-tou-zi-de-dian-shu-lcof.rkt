(define (num-rolls-to-target d f target)
  (define MOD 1000000007)

  (define dp (make-vector (+ d 1) #f))
  (for ([i (in-range (+ d 1))])
    (vector-set! dp i (make-vector (+ target 1) 0)))

  (vector-set! (vector-ref dp 0) 0 1)

  (for ([i (in-range 1 (+ d 1))])
    (for ([j (in-range 1 (+ target 1))])
      (for ([k (in-range 1 (+ f 1))])
        (when (>= (- j k) 0)
          (let* ([prev-sum-ways (vector-ref (vector-ref dp (- i 1)) (- j k))]
                 [current-ways (vector-ref (vector-ref dp i) j)])
            (vector-set! (vector-ref dp i) j
                         (modulo (+ current-ways prev-sum-ways) MOD)))))))

  (vector-ref (vector-ref dp d) target))