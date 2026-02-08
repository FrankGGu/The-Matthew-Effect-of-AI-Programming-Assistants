(define (sum-of-floored-pairs nums)
  (define n (length nums))
  (define mod 1000000007)
  (define (count-less-equal x)
    (let loop ([i 0] [count 0])
      (if (= i n)
          count
          (loop (+ i 1) (+ count (if (<= (list-ref nums i) x) 1 0))))))

  (define (solve)
    (let loop ([i 0] [total 0])
      (if (= i n)
          total
          (let* ([a (list-ref nums i)]
                 [sum 0]
                 [j 1])
            (let inner-loop ()
              (let ([lower (* j a)]
                    [upper (* (+ j 1) a)])
                (if (> lower (apply max nums))
                    sum
                    (let ([bound (min upper (apply max nums))])
                      (let ([cnt (count-less-equal bound)])
                        (if (>= cnt 0)
                            (let ([new-sum (modulo (+ sum (* j (count-less-equal bound)))) mod])
                                (if (< upper (apply max nums))
                                    (inner-loop)
                                    (let ([result (modulo (+ total new-sum) mod)])
                                         result)))))
                            (let ([result (modulo (+ total sum) mod)])
                                 result)))))
              (let ([result (modulo (+ total sum) mod)])
                   result))))))
  (solve))