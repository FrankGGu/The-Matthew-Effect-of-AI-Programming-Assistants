(define (divide-array nums k)
  (define sorted-nums (sort nums <))
  (define result '())
  (let loop ([nums sorted-nums])
    (cond
      [(null? nums) (reverse result)]
      [(<= (- (list-ref nums 2) (list-ref nums 0)) k)
       (loop (drop nums 3))
       (set! result (cons (list (list-ref nums 0) (list-ref nums 1) (list-ref nums 2)) result))]
      [else '()]))
  )