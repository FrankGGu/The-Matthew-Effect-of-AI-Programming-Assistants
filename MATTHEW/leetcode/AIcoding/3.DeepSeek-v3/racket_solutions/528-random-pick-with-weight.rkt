(define pick-index
  (let* ([prefix-sum #f]
         [total #f]
         [init (lambda (w)
                 (set! prefix-sum (for/list ([i (in-range (length w))]
                                             [sum (in-scanl + 0 w)])
                                    sum))
                 (set! total (last prefix-sum)))])
    (case-lambda
      [() (void)]
      [(w) (init w)]
      [() (let ([target (+ 1 (random total))])
            (let loop ([left 0]
                       [right (sub1 (length prefix-sum))])
              (if (>= left right)
                  right
                  (let* ([mid (quotient (+ left right) 2)]
                         [mid-val (list-ref prefix-sum mid)])
                    (if (< mid-val target)
                        (loop (add1 mid) right)
                        (loop left mid))))))])))