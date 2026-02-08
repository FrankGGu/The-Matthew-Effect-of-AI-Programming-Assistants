(define/contract (color-combo colors)
  (-> (listof exact-integer?) (listof (listof exact-integer?)))
  (let loop ([i 0] [res '()])
    (if (>= i (length colors))
        res
        (loop (add1 i)
              (append res
                     (for/list ([j (in-range (add1 i) (length colors))]
                                #:when (not (zero? (bitwise-and (list-ref colors i) (list-ref colors j)))))
                       (list (list-ref colors i) (list-ref colors j))))))))