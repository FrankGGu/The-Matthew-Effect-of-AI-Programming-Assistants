(define (length-of-lis nums)
  (define (tail-recursive-lis nums tails)
    (cond
      [(empty? nums) (length tails)]
      [else
       (define current-num (first nums))
       (define (binary-search left right)
         (cond
           [(>= left right) left]
           [else
            (define mid (floor (+ left right) 2))
            (cond
              [(<= (list-ref tails mid) current-num) (binary-search (+ mid 1) right)]
              [else (binary-search left mid)])]))
       (define index (binary-search 0 (length tails)))
       (if (= index (length tails))
           (tail-recursive-lis (rest nums) (append tails (list current-num)))
           (tail-recursive-lis (rest nums) (list-update tails index current-num)))]))

  (if (empty? nums)
      0
      (tail-recursive-lis (rest nums) (list (first nums)))))