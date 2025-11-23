(define/contract (can-three-parts-equal-sum arr)
  (-> (listof exact-integer?) boolean?)
  (let* ([total (apply + arr)]
         [target (/ total 3)]
         [n (length arr)])
    (if (not (integer? target))
        #f
        (let loop ([i 0] [sum 0] [parts 0])
          (cond
            [(= i n) (>= parts 3)]
            [else
             (let* ([new-sum (+ sum (list-ref arr i))]
                    [new-parts (if (= new-sum target) (+ parts 1) parts)])
               (loop (+ i 1) (if (= new-sum target) 0 new-sum) new-parts))])))))