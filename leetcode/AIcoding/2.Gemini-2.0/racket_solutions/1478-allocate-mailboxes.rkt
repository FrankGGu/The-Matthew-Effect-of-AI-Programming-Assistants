(define (min-distance houses k)
  (define n (length houses))
  (define (median lst)
    (let* ([sorted-lst (sort lst <)]
           [len (length sorted-lst)])
      (if (odd? len)
          (list-ref sorted-lst (quotient len 2))
          (let ([mid (quotient len 2)])
            (quotient (+ (list-ref sorted-lst (- mid 1)) (list-ref sorted-lst mid)) 2)))))

  (define (cost houses mailbox)
    (apply + (map (lambda (house) (abs (- house mailbox))) houses)))

  (define (min-cost houses l r)
    (let* ([sub-houses (take (drop houses l) (+ 1 (- r l)))])
      (cost sub-houses (median sub-houses))))

  (define dp (make-vector (+ n 1) (make-vector (+ k 1) #inf.0)))
  (vector-set! (vector-ref dp 0) 0 0)

  (for ([i (in-range 1 (+ n 1))])
    (for ([j (in-range 1 (+ k 1))])
      (for ([m (in-range 1 (+ i 1))])
        (vector-set! (vector-ref dp i) j (min (vector-ref (vector-ref dp i) j)
                                                 (+ (vector-ref (vector-ref dp (- i m)) (- j 1))
                                                    (min-cost houses (- i m) (- i 1))))))))
  (vector-ref (vector-ref dp n) k))