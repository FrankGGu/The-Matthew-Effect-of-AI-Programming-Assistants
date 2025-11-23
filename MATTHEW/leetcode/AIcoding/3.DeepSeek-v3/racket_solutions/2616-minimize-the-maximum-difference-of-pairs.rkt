(define/contract (minimize-max nums p)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([nums (sort nums <)]
         [n (length nums)]
         [left 0]
         [right (- (list-ref nums (- n 1)) (list-ref nums 0))])
    (define (count-pairs max-diff)
      (let loop ([i 0] [cnt 0])
        (if (>= i (- n 1))
            cnt
            (if (<= (- (list-ref nums (+ i 1)) (list-ref nums i)) max-diff)
                (loop (+ i 2) (+ cnt 1))
                (loop (+ i 1) cnt)))))
    (let binary-search ([low left] [high right] [res right])
      (if (> low high)
          res
          (let ([mid (quotient (+ low high) 2)])
            (if (>= (count-pairs mid) p)
                (binary-search low (- mid 1) mid)
                (binary-search (+ mid 1) high res)))))))