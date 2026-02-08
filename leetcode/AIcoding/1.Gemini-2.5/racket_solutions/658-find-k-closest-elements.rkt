(define (find-k-closest-elements arr k x)
  (let* ([n (length arr)]
         [low 0]
         [high (- n k)])

    (let loop ([low low] [high high])
      (if (>= low high)
          (sublist arr low (+ low k))
          (let* ([mid (+ low (quotient (- high low) 2))]
                 [val-mid (list-ref arr mid)]
                 [val-mid-k (list-ref arr (+ mid k))]
                 [dist-mid (abs (- val-mid x))]
                 [dist-mid-k (abs (- val-mid-k x))])
            (if (<= dist-mid dist-mid-k)
                (loop low mid)
                (loop (+ mid 1) high)))))))