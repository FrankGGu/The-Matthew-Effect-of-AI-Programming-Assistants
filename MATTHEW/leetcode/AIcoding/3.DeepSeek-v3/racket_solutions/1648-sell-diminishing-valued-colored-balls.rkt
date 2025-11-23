(define (max-profit inventory orders)
  (define (sum a b)
    (quotient (* (+ a b) (- b a -1)) 2))
  (let loop ([inv (sort inventory >)]
             [ord orders]
             [res 0])
    (if (zero? ord)
        res
        (let* ([m (car inv)]
               [n (length inv)]
               [d (if (or (null? (cdr inv)) (zero? (cadr inv)))
                       m
                       (- m (cadr inv)))])
          (if (<= (* n d) ord)
              (loop (cdr inv) (- ord (* n d)) (+ res (* n (sum (- m d -1) m))))
              (let* ([q (quotient ord n)]
                     [r (remainder ord n)]
                     [s (sum (- m q -1) m)])
                (+ res (* r (- m q)) (* n s))))))))