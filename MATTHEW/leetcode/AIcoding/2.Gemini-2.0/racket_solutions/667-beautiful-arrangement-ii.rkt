(define (construct-array n k)
  (let loop ([i 1] [j n] [result '()])
    (cond
      [(zero? k) (append result (range i (add1 j)))]
      [else
       (loop (add1 i) (sub1 j) (append result (list i (if (> k 1) j '()))))
      ])))