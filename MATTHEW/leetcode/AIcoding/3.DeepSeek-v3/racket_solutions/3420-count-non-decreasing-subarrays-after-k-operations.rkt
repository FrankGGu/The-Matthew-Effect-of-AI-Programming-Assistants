(define (count-subarrays nums operations)
  (let* ([n (length nums)]
         [k (car operations)]
         [x (cadr operations)]
         [nums (list->vector nums)]
         [prefix (make-vector (add1 n) 0)]
         [res 0])
    (for ([i (in-range 1 (add1 n))])
      (vector-set! prefix i (+ (vector-ref prefix (sub1 i)) 
                              (if (<= (vector-ref nums (sub1 i)) (vector-ref nums i)) 1 0)))
    (for ([i (in-range n)])
      (for ([j (in-range i n)])
        (let ([sum (+ (vector-ref prefix (add1 j)) 
                      (vector-ref prefix i))])
          (when (<= sum k)
            (set! res (add1 res))))))
    res))