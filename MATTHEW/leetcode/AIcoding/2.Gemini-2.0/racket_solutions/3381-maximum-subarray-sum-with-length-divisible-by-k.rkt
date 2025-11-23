(define (max-sub-array-len-divisible-by-k nums k)
  (define n (length nums))
  (define (prefix-sums)
    (let loop ([i 0] [acc '(0)] [sum 0])
      (if (= i n)
          (reverse acc)
          (let ([new-sum (+ sum (list-ref nums i))])
            (loop (+ i 1) (cons new-sum acc) new-sum)))))

  (define sums (prefix-sums))

  (define (remainders)
    (map (lambda (x) (modulo x k)) sums))

  (define rems (remainders))

  (define (find-max-len)
    (let loop ([i 0] [max-len 0])
      (if (= i n)
          max-len
          (let loop2 ([j (+ i 1)])
            (if (= j (+ n 1))
                (loop (+ i 1) max-len)
                (if (= (modulo (- (list-ref sums j) (list-ref sums i)) k) 0)
                    (loop2 (+ j 1))
                    (let ([new-len (- j i)])
                      (loop (+ i 1) (max max-len new-len)))))))))

  (let loop ([i 0] [max-len 0])
      (if (= i n)
          max-len
          (let loop2 ([j (+ i 1)])
            (if (= j (+ n 1))
                (loop (+ i 1) max-len)
                (if (= (modulo (- (list-ref sums j) (list-ref sums i)) k) 0)
                    (let ([new-len (- j i)])
                      (loop (+ i 1) (max max-len new-len)))
                    (loop2 (+ j 1)))))))
)