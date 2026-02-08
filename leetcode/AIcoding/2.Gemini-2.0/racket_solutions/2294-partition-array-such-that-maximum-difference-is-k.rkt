(define (partitionArray nums k)
  (define sorted-nums (sort nums <))
  (define (helper sorted-nums current-partition count)
    (cond
      [(empty? sorted-nums) count]
      [else
       (define first-element (first sorted-nums))
       (define (find-end-index sorted-nums first-element k index)
         (cond
           [(empty? sorted-nums) index]
           [else
            (if (<= (- (first sorted-nums) first-element) k)
                (find-end-index (rest sorted-nums) first-element k (+ index 1))
                index)]))
       (define end-index (find-end-index sorted-nums first-element k 0))
       (helper (drop sorted-nums end-index) '() (+ count 1))]))
  (helper sorted-nums '() 0))