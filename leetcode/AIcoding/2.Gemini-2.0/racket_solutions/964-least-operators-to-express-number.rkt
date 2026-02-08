(define (least-ops target x)
  (define memo (make-hash))

  (define (dp n)
    (cond
      [(hash-has-key? memo n) (hash-ref memo n)]
      [(= n 0) (if (> x 1) #f 2)]
      [(= n x) 1]
      [(> n x)
       (let* ([q (floor (/ n x))]
              [r (modulo n x)]
              [res (+ (min (+ (* q (dp x)) q)
                         (+ (* (+ q 1) (dp x)) (+ q 1)))
                       1)])
         (hash-set! memo n res)
         res)]
      [else
       (let* ([q (floor (/ x n))]
              [r (modulo x n)]
              [res (+ (dp (- x n)) 2)])
         (hash-set! memo n res)
         res)]))

  (dp target))