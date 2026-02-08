(define (count-digit-one n)
  (let loop ([m 1] [count 0])
    (if (> m n)
        count
        (let* ([div (* m 10)]
               [q (quotient n div)]
               [r (remainder n div)]
               [add (* q m)]
               [add (if (>= r m)
                        (if (< r (* 2 m)) 
                            (+ add (- r m -1))
                            (+ add m))
                        add)])
          (loop div (+ count add))))))