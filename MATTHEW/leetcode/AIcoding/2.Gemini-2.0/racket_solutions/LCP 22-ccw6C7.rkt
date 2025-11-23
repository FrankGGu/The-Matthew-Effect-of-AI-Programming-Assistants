(define (paintingGrid n m k)
  (let ([row-ways (expt 2 m)])
    (let loop ([i 0] [count 0])
      (if (= i (+ k 1))
          count
          (let ([comb (binomial n i)])
            (let ([valid-rows (loop-valid-rows 0 0)])
              (loop (+ i 1) (+ count (* comb valid-rows)))))
          ))
    )
  )

(define (loop-valid-rows i current-count)
  (if (= i (+ 1 (min k n)))
      current-count
      (let ([ways (valid-rows-for-i i)])
        (loop-valid-rows (+ i 1) (+ current-count ways))))
  )

(define (valid-rows-for-i i)
  (let ([comb (binomial n i)])
    (* comb (expt -1 i))
    )
  )

(define (valid-rows-for-i i)
  (let ([row-ways (expt 2 m)])
    (expt (- row-ways 2) (- n i)))
  )

(define (valid-rows-for-i k)
  (let ([row-ways (expt 2 m)])
  (let ([result 0])
    (let loop ([i 0])
      (if (> i k)
          result
          (let ([comb (binomial k i)])
            (loop (+ i 1) (+ result (* comb (expt (- row-ways 2) (- k i)))))))
          ))
    )
  )

(define (binomial n k)
  (if (or (< k 0) (> k n))
      0
      (let loop ([n n] [k k] [acc 1])
        (if (or (= k 0) (= acc 0))
            acc
            (loop (- n 1) (- k 1) (/ (* acc n) k))))))

(define (paintingGrid n m k)
  (let ([row-ways (expt 2 m)])
    (let ([valid-rows (expt (- row-ways 2) n)])
      (let ([total 0])
        (let loop ([i 0])
          (if (> i k)
              total
              (let ([comb (binomial n i)])
                (loop (+ i 1) (+ total (* comb (expt row-ways (- n i))))))))))))