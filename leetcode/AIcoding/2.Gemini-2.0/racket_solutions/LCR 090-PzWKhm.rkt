(define (rob nums)
  (define (rob-range nums start end)
    (define (rob-helper nums k)
      (cond [(< k 0) 0]
            [(< k 1) (list-ref nums k)]
            [else (max (+ (list-ref nums k) (rob-helper nums (- k 2)))
                       (rob-helper nums (- k 1)))]))
    (rob-helper (take (drop nums start) (- end start -1)) (- (- end start) 2)))

  (cond [(null? nums) 0]
        [(< (length nums) 2) (first nums)]
        [else (max (rob-range nums 0 (- (length nums) 1))
                   (rob-range nums 1 (length nums)))]))