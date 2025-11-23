(define (max-sum-with-k-elements nums k)
  (define (helper nums k current-sum current-count)
    (cond
      [(or (null? nums) (= current-count k)) current-sum]
      [else
       (let* ([first-num (car nums)]
              [rest-nums (cdr nums)]
              [include-sum (helper rest-nums k (+ current-sum first-num) (+ current-count 1))]
              [exclude-sum (helper rest-nums k current-sum current-count)])
         (max include-sum exclude-sum))]))

  (define (helper2 nums k)
    (define n (length nums))
    (define dp (make-vector (+ n 1) (make-vector (+ k 1) 0)))

    (for ([i (in-range 1 (+ n 1))])
      (for ([j (in-range 1 (+ k 1))])
        (let ([current-num (list-ref nums (- i 1))])
          (vector-set! (vector-ref dp i) j (max (vector-ref (vector-ref dp (- i 1)) j)
                                                  (+ current-num (if (> j 1) (vector-ref (vector-ref dp (- i 1)) (- j 1)) 0)))))))

    (vector-ref (vector-ref dp n) k))

  (helper2 nums k))