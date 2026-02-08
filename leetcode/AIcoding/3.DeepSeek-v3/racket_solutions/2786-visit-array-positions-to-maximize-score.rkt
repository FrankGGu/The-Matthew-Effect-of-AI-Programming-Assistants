(define/contract (max-score nums x)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([i 1]
             [even-sum (if (even? (first nums)) (first nums) -inf.0)]
             [odd-sum (if (odd? (first nums)) (first nums) -inf.0)])
    (if (>= i (length nums))
        (max even-sum odd-sum)
        (let ([current (list-ref nums i)]
              [next-even (if (even? (list-ref nums i))
                            (max (+ even-sum current) (+ odd-sum (- current x)))
                            even-sum)]
              [next-odd (if (odd? (list-ref nums i))
                           (max (+ odd-sum current) (+ even-sum (- current x)))
                           odd-sum)])
          (loop (add1 i) next-even next-odd)))))