(define/contract (find-diagonal-order mat)
  (-> (listof (listof exact-integer?)) (listof exact-integer?))
  (if (null? mat) '()
      (let* ([m (length mat)]
             [n (length (car mat))]
             [result '()]
             [row 0]
             [col 0]
             [direction 1])
        (for ([i (range (* m n))])
          (set! result (cons (list-ref (list-ref mat row) col) result))
          (if (= direction 1)
              (if (= col (- n 1))
                  (begin (set! row (+ row 1)) (set! direction -1))
                  (if (= row 0)
                      (begin (set! col (+ col 1)) (set! direction -1))
                      (begin (set! row (- row 1)) (set! col (+ col 1))))
              (if (= row (- m 1))
                  (begin (set! col (+ col 1)) (set! direction 1))
                  (if (= col 0)
                      (begin (set! row (+ row 1)) (set! direction 1))
                      (begin (set! row (+ row 1)) (set! col (- col 1)))))))
        (reverse result))))