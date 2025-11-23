(define (can-arrange? arr k)
  (let ((remainders (make-vector k 0)))
    (for ([num arr])
      (let ((rem (modulo num k)))
        (vector-set! remainders rem (add1 (vector-ref remainders rem)))))
    (if (odd? (vector-ref remainders 0))
        #f
        (let loop ([i 1])
          (cond
            [(>= i (/ k 2))
             (if (= k (* 2 i))
                 (if (odd? (vector-ref remainders i))
                     #f
                     #t)
                 #t)]
            [(= (vector-ref remainders i) (vector-ref remainders (- k i)))
             (loop (add1 i))]
            [else #f])))))