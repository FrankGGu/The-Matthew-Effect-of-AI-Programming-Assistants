(define (find-special-integer arr)
  (let* ([n (vector-length arr)]
         [quarter-len (floor (/ n 4))])
    (for/first ([i (in-range (- n quarter-len))]
                #:when (= (vector-ref arr i) (vector-ref arr (+ i quarter-len))))
      (vector-ref arr i))))