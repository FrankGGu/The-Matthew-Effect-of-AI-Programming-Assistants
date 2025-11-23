(define (product-except-self nums)
  (let* ([n (length nums)]
         [ans (make-vector n 1)]
         [nums-vec (list->vector nums)])

    (let loop ([i 0] [p 1])
      (when (< i n)
        (vector-set! ans i p)
        (loop (+ i 1) (* p (vector-ref nums-vec i)))))

    (let loop ([i (- n 1)] [s 1])
      (when (>= i 0)
        (vector-set! ans i (* (vector-ref ans i) s))
        (loop (- i 1) (* s (vector-ref nums-vec i)))))

    (vector->list ans)))