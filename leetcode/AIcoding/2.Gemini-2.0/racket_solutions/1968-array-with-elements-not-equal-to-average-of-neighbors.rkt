(define (rearrange nums)
  (define (swap! arr i j)
    (let ((temp (vector-ref arr i)))
      (vector-set! arr i (vector-ref arr j))
      (vector-set! arr j temp)))

  (define arr (list->vector nums))
  (sort! arr <)

  (let loop ((i 1))
    (cond
      ((>= i (sub1 (vector-length arr))) arr)
      (else
       (swap! arr i (+ i 1))
       (loop (+ i 2)))))

  (vector->list arr))