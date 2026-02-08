(define (min-capability nums k)
  (define (can-rob capability)
    (define (helper nums idx count)
      (cond
        [(>= count k) #t]
        [(>= idx (length nums)) #f]
        [(<= (list-ref nums idx) capability) (helper nums (+ idx 2) (+ count 1))]
        [else (helper nums (+ idx 1) count)]))
    (helper nums 0 0))

  (define (binary-search left right)
    (cond
      [(>= left right) left]
      [else
       (let* ([mid (floor (+ left right) 2)]
              [can-rob-mid (can-rob mid)])
         (if can-rob-mid
             (binary-search left mid)
             (binary-search (+ mid 1) right)))]))

  (binary-search (apply min nums) (apply max nums)))