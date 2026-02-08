(define (length-of-lis nums)
  (define n (vector-length nums))
  (if (= n 0)
      0
      (let ([tails (make-vector n 0)] ; tails[i] stores the smallest tail of all increasing subsequences of length i+1
            [len 0]) ; Current length of the longest increasing subsequence

        (for ([num (in-vector nums)])
          ;; Find the smallest `tails[idx]` such that `tails[idx] >= num`
          ;; This is equivalent to finding the insertion point for `num`
          ;; in `tails` to maintain its sorted property.
          (let* ([low 0]
                 [high len]
                 [idx (let search-loop ([l low] [h high] [ans high])
                        (if (= l h)
                            ans
                            (let ([mid (+ l (quotient (- h l) 2))])
                              (if (< (vector-ref tails mid) num)
                                  (search-loop (+ mid 1) h ans)
                                  (search-loop l mid mid)))))]
            (vector-set! tails idx num)
            (when (= idx len)
              (set! len (+ len 1))))
        len)))