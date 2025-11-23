(define/contract (valid-partition nums)
  (-> (listof exact-integer?) boolean?)
  (let ([n (length nums)])
    (let dp ([i 0] [memo (make-hash)])
      (cond
        [(= i n) #t]
        [(hash-has-key? memo i) (hash-ref memo i)]
        [else
         (let ([res #f])
           (when (>= (- n i) 2)
             (let ([a (list-ref nums i)]
                   [b (list-ref nums (+ i 1))])
               (when (or (= a b)
                         (and (>= (- n i) 3)
                              (let ([c (list-ref nums (+ i 2))])
                                (or (and (= a b) (= b c))
                                    (and (= a (- b 1)) (= b (- c 1)))))))
                 (set! res (or res (dp (+ i (if (= a b) 2 3)) memo))))))
           (hash-set! memo i res)
           res)]))))