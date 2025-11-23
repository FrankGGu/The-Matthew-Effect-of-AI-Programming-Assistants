(define (count-subarrays nums k)
  (define (helper nums k start end)
    (cond
      [(>= start end) 0]
      [else
       (let ([first (list-ref nums start)]
             [last (list-ref nums (- end 1))])
         (if (and (>= first k) (>= last k))
             (+ (- end start) (helper nums k (+ start 1) end) (helper nums k start (- end 1)) (- (helper nums k (+ start 1) (- end 1)) ))
             (helper nums k (+ start 1) end)))]))
  (helper nums k 0 (length nums)))