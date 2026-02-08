(define/contract (k-length-apart nums k)
  (-> (listof exact-integer?) exact-integer? boolean?)
  (let loop ([nums nums] [prev -1] [min-dist (length nums)])
    (cond
      [(empty? nums) #t]
      [(= (first nums) 1)
       (if (and (>= prev 0) (< (- prev min-dist) k))
           #f
           (loop (rest nums) 0 min-dist))]
      [else
       (loop (rest nums) (if (>= prev 0) (add1 prev) prev) min-dist)])))