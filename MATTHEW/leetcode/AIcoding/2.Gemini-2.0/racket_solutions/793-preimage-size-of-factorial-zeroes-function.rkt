(define (trailing-zeroes n)
  (let loop ([n n] [count 0])
    (if (< n 5)
        count
        (loop (quotient n 5) (+ count (quotient n 5))))))

(define (find-k x)
  (let loop ([low 0] [high (* 5 x)])
    (if (<= low high)
        (let ([mid (quotient (+ low high) 2)])
          (let ([zeros (trailing-zeroes mid)])
            (cond
              [(< zeros x) (loop (+ mid 1) high)]
              [(> zeros x) (loop low (- mid 1))]
              [else mid])))
        -1)))

(define (preimage-size k)
  (if (< k 0)
      0
      (let ([z (find-k k)])
        (if (= z -1)
            0
            (let ([lower (find-k k)])
              (let ([upper (find-k (+ k 1))])
                (if (= upper -1)
                    (let loop ([i k])
                      (if (= (trailing-zeroes (* 5 i)) k)
                          5
                          (loop (+ i 1))))
                    (- upper lower))))))))

(define (preimage-size-efficient k)
  (if (< k 0)
      0
      5))