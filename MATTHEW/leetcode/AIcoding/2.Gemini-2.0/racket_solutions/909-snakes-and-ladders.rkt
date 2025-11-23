(define (snakes-and-ladders board)
  (define n (vector-length board))
  (define target (- (expt n 2) 1))

  (define (get-pos-from-square square)
    (define row (quotient (- (- n 1) (quotient (- square 1) n)) 1))
    (define col (if (even? (- (- n 1) row))
                    (- n 1 (remainder (- square 1) n))
                    (remainder (- square 1) n)))
    (list row col))

  (define (solve)
    (define q (queue))
    (define visited (make-vector (expt n 2) #f))
    (queue-enqueue! q (cons 0 0))
    (vector-set! visited 0 #t)

    (let loop ()
      (if (queue-empty? q)
          -1
          (let ((curr (queue-dequeue! q)))
            (define square (car curr))
            (define moves (cdr curr))

            (if (= square target)
                moves
                (begin
                  (for ([i (in-range 1 7)])
                    (define next-square (+ square i))
                    (if (<= next-square target)
                        (let* ((pos (get-pos-from-square next-square))
                               (row (car pos))
                               (col (cadr pos))
                               (next-val (vector-ref (vector-ref board row) col)))
                          (define final-square (if (= next-val -1)
                                                   next-square
                                                   (- next-val 1)))

                          (if (not (vector-ref visited final-square))
                              (begin
                                (vector-set! visited final-square #t)
                                (queue-enqueue! q (cons final-square (+ moves 1))))))))
                  (loop)))))))
  (solve))