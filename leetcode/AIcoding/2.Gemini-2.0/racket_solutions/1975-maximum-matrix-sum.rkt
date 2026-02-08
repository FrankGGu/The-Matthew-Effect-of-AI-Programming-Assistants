(define (max-matrix-sum matrix)
  (let* ([n (length matrix)]
         [m (length (first matrix))]
         [neg-count (for/sum ([i (in-range n)]
                             [j (in-range m)]
                             [#:when (< (list-ref (list-ref matrix i) j) 0)]
                             1))
         ]
         [total-abs-sum (for/sum ([i (in-range n)]
                                 [j (in-range m)])
                           (abs (list-ref (list-ref matrix i) j)))]
         )
    (if (even? neg-count)
        total-abs-sum
        (- total-abs-sum (* 2 (min (for/list ([i (in-range n)]
                                             [j (in-range m)])
                                     (abs (list-ref (list-ref matrix i) j)))))))
    ))