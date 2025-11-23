(define (shortest-subarray nums k)
  (let* ([n (length nums)]
         [prefix-or (make-vector (+ n 1) 0)])
    (for ([i (in-range n)])
      (vector-set! prefix-or (+ i 1) (bitwise-ior (vector-ref prefix-or i) (list-ref nums i))))

    (let loop ([left 0] [right 0] [min-len (+ n 1)])
      (cond
        [(> right n) min-len]
        [(>= (vector-ref prefix-or right) k)
         (let loop2 ([l left])
           (cond
             [(> l right) (loop (+ right 1) (+ right 1) min-len)]
             [(>= (bitwise-ior (vector-ref prefix-or right) (bitwise-not (vector-ref prefix-or l))) k)
              (loop2 (+ l 1))]
             [else
              (loop (+ right 1) (+ right 1) (min min-len (- right l)))]))]
        [else
         (loop left (+ right 1) min-len)]))))