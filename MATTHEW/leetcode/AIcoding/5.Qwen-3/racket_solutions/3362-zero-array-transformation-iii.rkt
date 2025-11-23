(define (zero-array-iii queries)
  (define (solve queries)
    (let loop ([q queries] [res 0] [sum 0] [cnt 0])
      (if (null? q)
          res
          (let* ([x (caar q)]
                 [y (cadar q)]
                 [val (caddar q)])
            (loop (cdr q) (+ res (* val (- y x 1))) sum cnt)))))
  (solve queries))