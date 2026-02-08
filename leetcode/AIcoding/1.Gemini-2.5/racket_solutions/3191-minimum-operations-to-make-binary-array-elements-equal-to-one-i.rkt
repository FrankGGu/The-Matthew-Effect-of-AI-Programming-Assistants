(define (min-operations nums)
  (define n (length nums))
  (define arr (list->vector nums))
  (define operations 0)

  (for ([i (in-range 0 (- n 2))])
    (when (= (vector-ref arr i) 0)
      (set! operations (+ operations 1))
      (vector-set! arr i (1 - (vector-ref arr i)))
      (vector-set! arr (+ i 1) (1 - (vector-ref arr (+ i 1))))
      (vector-set! arr (+ i 2) (1 - (vector-ref arr (+ i 2))))))

  (if (or (= (vector-ref arr (- n 2)) 0)
          (= (vector-ref arr (- n 1)) 0))
      -1
      operations))