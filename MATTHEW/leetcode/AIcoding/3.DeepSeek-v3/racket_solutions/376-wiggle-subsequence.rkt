(define/contract (wiggle-max-length nums)
  (-> (listof exact-integer?) exact-integer?)
  (if (null? nums) 0
      (let loop ([prev-diff 0] [count 1] [i 1])
        (if (>= i (length nums)) count
            (let ([diff (- (list-ref nums i) (list-ref nums (- i 1)))])
              (if (or (and (> prev-diff 0) (<= diff 0))
                      (and (< prev-diff 0) (>= diff 0))
                      (= prev-diff 0))
                  (loop diff (+ count (if (= diff 0) 0 1)) (+ i 1))
                  (loop prev-diff count (+ i 1))))))))