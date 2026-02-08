(define/contract (smallest-distance-pair nums k)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([nums (sort nums <)]
         [n (length nums)]
         [left 0]
         [right (- (list-ref nums (- n 1)) (list-ref nums 0)]))
  (define (count-pairs mid)
    (let loop ([i 0] [j 1] [count 0])
      (if (>= i n)
          count
          (if (and (< j n) (<= (- (list-ref nums j) (list-ref nums i)) mid)
              (loop i (+ j 1) count)
              (loop (+ i 1) j (+ count (- j i 1)))))))
  (let binary-search ([left left] [right right])
    (if (>= left right)
        left
        (let ([mid (quotient (+ left right) 2)])
          (if (>= (count-pairs mid) k)
              (binary-search left mid)
              (binary-search (+ mid 1) right))))))