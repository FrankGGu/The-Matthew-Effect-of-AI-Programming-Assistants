(define (sum-of-squares-ii nums)
  (define n (length nums))
  (define (distinct-element-sum-of-squares sub)
    (let ([distinct-elements (remove-duplicates sub)])
      (expt (apply + distinct-elements) 2)))

  (define (subarrays lst)
    (let loop ([i 0] [result '()])
      (if (= i n)
          result
          (let loop2 ([j i] [sub '()])
            (if (= j n)
                (loop (+ i 1) result)
                (let ([new-sub (append sub (list (list-ref lst j)))])
                  (loop2 (+ j 1) (append result (list (apply append new-sub))))))))))

  (apply + (map distinct-element-sum-of-squares (subarrays nums))))