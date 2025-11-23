(define/contract (max-distance position m)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let* ([position (sort position <)]
         [n (length position)]
         [left 0]
         [right (- (list-ref position (- n 1)) (list-ref position 0))])
    (define (can-place d)
      (let loop ([prev (list-ref position 0)]
                 [count 1]
                 [i 1])
        (if (>= count m)
            #t
            (if (>= i n)
                #f
                (if (>= (- (list-ref position i) prev) d)
                    (loop (list-ref position i) (+ count 1) (+ i 1))
                    (loop prev count (+ i 1))))))))
    (let binary-search ([left left]
                        [right right])
      (if (<= left right)
          (let* ([mid (quotient (+ left right) 2)]
                 [placed (can-place mid)])
            (if placed
                (binary-search (+ mid 1) right)
                (binary-search left (- mid 1))))
          right))))