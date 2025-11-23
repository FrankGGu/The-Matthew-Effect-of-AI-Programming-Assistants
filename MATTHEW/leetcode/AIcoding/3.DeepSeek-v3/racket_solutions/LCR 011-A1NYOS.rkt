(define/contract (find-max-length nums)
  (-> (listof exact-integer?) exact-integer?)
  (let ([sum-map (make-hash (list (cons 0 -1)))]
        [max-len 0]
        [count 0])
    (for ([i (in-range (length nums))]
         (let ([num (list-ref nums i)])
           (set! count (if (= num 1) (add1 count) (sub1 count)))
           (if (hash-has-key? sum-map count)
               (set! max-len (max max-len (- i (hash-ref sum-map count))))
               (hash-set! sum-map count i))))
    max-len))