(define/contract (interval-intersection first-list second-list)
  (-> (listof (listof exact-integer?)) (listof (listof exact-integer?)) (listof (listof exact-integer?)))
  (let loop ([i 0] [j 0] [res '()])
    (if (or (>= i (length first-list)) (>= j (length second-list)))
        (reverse res)
        (let* ([a (list-ref first-list i)]
               [b (list-ref second-list j)]
               [start (max (first a) (first b))]
               [end (min (second a) (second b))])
          (if (<= start end)
              (loop i j (cons (list start end) res))
              (if (< (second a) (second b))
                  (loop (add1 i) j res)
                  (loop i (add1 j) res)))))))