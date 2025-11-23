(define/contract (kth-smallest matrix k)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (let* ([n (length matrix)]
         [low (caar matrix)]
         [high (last (last matrix))])
    (define (count-less-equal mid)
      (let loop ([i 0]
                 [j (sub1 n)]
                 [count 0])
        (if (or (>= i n) (< j 0))
            count
            (if (<= (list-ref (list-ref matrix i) j) mid)
                (loop (add1 i) j (+ count (add1 j)))
                (loop i (sub1 j) count)))))
    (let binary-search ([low low]
                       [high high])
      (if (= low high)
          low
          (let* ([mid (quotient (+ low high) 2)]
                 [count (count-less-equal mid)])
            (if (< count k)
                (binary-search (add1 mid) high)
                (binary-search low mid)))))))