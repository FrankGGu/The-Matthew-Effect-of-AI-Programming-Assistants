(define (can-partition-k-subsets nums k)
  (let* ([total (apply + nums)]
         [target (/ total k)]
         [n (length nums)])
    (if (not (integer? target))
        #f
        (let ([used (make-vector n #f)])
          (define (backtrack start k-left current-sum)
            (cond [(= k-left 0) #t]
                  [(= current-sum target) (backtrack 0 (sub1 k-left) 0)]
                  [else
                   (for/fold ([result #f])
                             ([i (in-range start n)] #:break result)
                     (when (and (not (vector-ref used i))
                                (<= (+ current-sum (list-ref nums i)) target))
                       (vector-set! used i #t)
                       (set! result (backtrack (add1 i) k-left (+ current-sum (list-ref nums i))))
                       (vector-set! used i #f)
                       result)]))
          (backtrack 0 k 0)))))