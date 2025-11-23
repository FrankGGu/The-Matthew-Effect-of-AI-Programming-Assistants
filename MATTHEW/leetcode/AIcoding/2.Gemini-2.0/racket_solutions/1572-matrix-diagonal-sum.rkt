(define (diagonal-sum mat)
  (let* ([n (length mat)]
         [sum (for/sum ([i (in-range n)])
                (+ (list-ref (list-ref mat i) i)
                   (list-ref (list-ref mat i) (- n i 1))))])
    (if (odd? n)
        (- sum (list-ref (list-ref mat (quotient n 2)) (quotient n 2)))
        sum)))