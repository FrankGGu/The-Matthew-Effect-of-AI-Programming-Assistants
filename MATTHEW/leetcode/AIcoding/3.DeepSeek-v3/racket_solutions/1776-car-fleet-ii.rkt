(define/contract (get-collision-times cars)
  (-> (listof (listof exact-integer?)) (listof flonum?))
  (define n (length cars))
  (define res (make-vector n -1.0))
  (define stack '())

  (for ([i (in-range (- n 1) -1 -1)])
    (define pos (list-ref (list-ref cars i) 0))
    (define speed (list-ref (list-ref cars i) 1))

    (while (and (not (null? stack))
                (let* ([j (car stack)]
                       [pos_j (list-ref (list-ref cars j) 0)]
                       [speed_j (list-ref (list-ref cars j) 1)])
                  (if (<= speed speed_j)
                      (set! stack (cdr stack))
                      (let ([collide_time (/ (- pos_j pos) (- speed speed_j))])
                        (if (or (= (vector-ref res j) -1.0)
                              (< collide_time (vector-ref res j)))
                            (begin
                              (vector-set! res i collide_time)
                              (break))
                            (set! stack (cdr stack)))))))

    (set! stack (cons i stack)))

  (vector->list res))