(define/contract (minimum-difference nums)
  (-> (listof exact-integer?) exact-integer?)
  (let* ([n (quotient (length nums) 2)]
         [total (apply + nums)]
         [half (quotient total 2)]
         [left (take nums n)]
         [right (drop nums n)]
         [left-sums (make-hash)]
         [right-sums (make-hash)])
    (for ([k (in-range (add1 n))])
      (hash-set! left-sums k (sort (for/list ([comb (in-combinations left k)])
                                     (apply + comb)) <))
      (hash-set! right-sums k (sort (for/list ([comb (in-combinations right k)])
                                     (apply + comb)) <))
    (let loop ([k 0]
               [best-abs-diff +inf.0])
      (if (> k n)
          best-abs-diff
          (let* ([left-list (hash-ref left-sums k)]
                  [right-list (hash-ref right-sums (- n k))]
                  [current-best (for*/fold ([current-best best-abs-diff])
                                           ([l (in-list left-list)]
                                            [r (in-list right-list)])
                                  (let ([sum (+ l r)]
                                        [diff (abs (- total (* 2 (+ l r))))])
                                    (if (< diff current-best)
                                        diff
                                        current-best)))])
            (loop (add1 k) current-best)))))))