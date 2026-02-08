(define (find-kth-smallest-pair-distance nums k)
  (define (count-pairs-less-than dist)
    (let loop ([i 0] [j 1] [count 0])
      (cond
        [(>= j (length nums)) count]
        [(< i (length nums))
         (if (<= (- (list-ref nums j) (list-ref nums i)) dist)
             (loop i (+ j 1) (+ count (- j i)))
             (loop (+ i 1) j count))]
        [else count])))

  (define (binary-search left right)
    (cond
      [(> left right) left]
      [else
       (let ([mid (quotient (+ left right) 2)])
         (if (>= (count-pairs-less-than mid) k)
             (binary-search left (- mid 1))
             (binary-search (+ mid 1) right)))]))

  (let ([sorted-nums (sort nums <)])
    (binary-search 0 (- (last sorted-nums) (first sorted-nums)))))