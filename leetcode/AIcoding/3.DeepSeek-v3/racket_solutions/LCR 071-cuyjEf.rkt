(define pick-index
  (let* ([w #f]
         [prefix #f]
         [total 0]
         [n 0])
    (lambda (ws)
      (unless w
        (set! w ws)
        (set! n (length w))
        (set! prefix (make-vector n 0))
        (vector-set! prefix 0 (list-ref w 0))
        (for ([i (in-range 1 n)])
          (vector-set! prefix i (+ (vector-ref prefix (- i 1)) (list-ref w i))))
        (set! total (vector-ref prefix (- n 1)))))
      (let ([target (+ 1 (random total))])
        (let loop ([left 0] [right (- n 1)])
          (if (= left right)
              left
              (let* ([mid (quotient (+ left right) 2)]
                     [mid-val (vector-ref prefix mid)])
                (if (< mid-val target)
                    (loop (+ mid 1) right)
                    (loop left mid))))))))