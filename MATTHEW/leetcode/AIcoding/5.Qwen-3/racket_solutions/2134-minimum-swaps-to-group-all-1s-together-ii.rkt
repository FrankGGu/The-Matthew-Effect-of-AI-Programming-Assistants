(define (min-swaps arr)
  (define n (length arr))
  (define total-ones (apply + arr))
  (if (= total-ones 0) 0
      (let loop ([i 0] [current-ones 0] [min-swaps (add1 n)])
        (if (>= i n) min-swaps
            (let ([current-ones (if (= (list-ref arr i) 1) (add1 current-ones) current-ones)])
              (if (<= i (- total-ones 1))
                  (loop (add1 i) current-ones min-swaps)
                  (let ([swaps (- total-ones current-ones)])
                    (loop (add1 i) (if (= (list-ref arr (- i total-ones)) 1) (sub1 current-ones) current-ones) (min min-swaps swaps)))))))))