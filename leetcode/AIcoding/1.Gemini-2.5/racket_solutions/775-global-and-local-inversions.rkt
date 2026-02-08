(define (is-ideal-permutation nums)
  (let* ((n (vector-length nums)))
    (when (< n 3)
      #t)

    (define suffix-min (make-vector n 0))

    (vector-set! suffix-min (- n 1) (vector-ref nums (- n 1)))

    (for ((i (range (- n 2) -1 -1)))
      (vector-set! suffix-min i (min (vector-ref nums i) (vector-ref suffix-min (+ i 1)))))

    (let loop ((i 0))
      (cond
        ((>= i (- n 2))
         #t)
        ((> (vector-ref nums i) (vector-ref suffix-min (+ i 2)))
         #f)
        (else
         (loop (+ i 1)))))))