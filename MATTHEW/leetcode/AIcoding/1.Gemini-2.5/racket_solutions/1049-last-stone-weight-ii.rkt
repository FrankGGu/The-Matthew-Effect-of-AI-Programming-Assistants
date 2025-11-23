(define (last-stone-weight-ii stones)
  (let* ([total-sum (apply + stones)]
         [target-sum (floor (/ total-sum 2))]
         [dp (make-vector (+ target-sum 1) #f)])
    (vector-set! dp 0 #t)

    (for-each (lambda (stone)
                (for ([j (in-range target-sum (sub1 stone) -1)])
                  (when (vector-ref dp (- j stone))
                    (vector-set! dp j #t))))
              stones)

    (let loop ([j target-sum])
      (cond
        [(< j 0) total-sum]
        [(vector-ref dp j)
         (- total-sum (* 2 j))]
        [else (loop (- j 1))])))
)