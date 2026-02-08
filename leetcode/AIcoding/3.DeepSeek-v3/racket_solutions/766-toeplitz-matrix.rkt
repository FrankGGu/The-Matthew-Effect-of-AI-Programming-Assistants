(define/contract (is-toeplitz-matrix matrix)
  (-> (listof (listof exact-integer?)) boolean?)
  (let loop-row ([i 0])
    (cond
      [(>= i (sub1 (length matrix))) #t]
      [else
       (let loop-col ([j 0])
         (cond
           [(>= j (sub1 (length (list-ref matrix i)))) #t]
           [(not (= (list-ref (list-ref matrix i) j)
                   (list-ref (list-ref matrix (add1 i)) (add1 j))))
            #f]
           [else (loop-col (add1 j))]))
       (and (loop-col 0) (loop-row (add1 i)))])))