(define (count-digit-one n)
  (let loop ([k 1] [count 0])
    (if (> k n)
        count
        (let* ([div (* k 10)]
               [q (quotient n div)]
               [r (remainder n div)]
               [add (* q k)]
               [add (if (> r (sub1 (* 2 k)))
                        k
                        (if (< r k)
                            0
                            (- r k -1)))]
               [add (+ add (* q k))])
          (loop (* k 10) (+ count add))))))