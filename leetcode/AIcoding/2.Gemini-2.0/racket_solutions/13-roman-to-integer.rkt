(define (roman-to-int s)
  (define roman-map
    (hash
     (#\I 1)
     (#\V 5)
     (#\X 10)
     (#\L 50)
     (#\C 100)
     (#\D 500)
     (#\M 1000)))

  (define (helper s acc prev)
    (cond
      [(string=? s "") acc]
      [else
       (let* ([curr (hash-ref roman-map (string-ref s 0))]
              [rest (substring s 1)])
         (if (> curr prev)
             (helper rest (+ acc curr (- prev prev)) curr)
             (helper rest (+ acc curr) curr)))])
    )

  (helper s 0 0))