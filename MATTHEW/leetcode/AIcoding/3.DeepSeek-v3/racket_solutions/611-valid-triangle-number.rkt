(define/contract (triangle-number nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([nums (sort nums <)]
        [count 0])
    (for ([k (in-range (sub1 (length nums)) (sub1 0) -1)])
      (let ([i 0]
            [j (sub1 k)])
        (while (< i j)
          (if (> (+ (list-ref nums i) (list-ref nums j)) (list-ref nums k))
              (begin
                (set! count (+ count (- j i)))
                (set! j (sub1 j)))
              (set! i (add1 i))))))
    count))