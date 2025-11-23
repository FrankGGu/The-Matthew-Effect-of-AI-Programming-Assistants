(define (snakes-and-ladders board)
  (define n (length board))
  (define (pos->coord pos)
    (let* ((row (/ (- n 1) (quotient (- pos 1) n)))
           (col (modulo (- pos 1) n)))
      (if (odd? row)
          (list row (- n 1 col))
          (list row col))))

  (define (bfs)
    (define visited (make-vector (+ (* n n) 1) #f))
    (define q (list 1))
    (define steps 0)
    (vector-set! visited 1 #t)

    (while (not (null? q))
      (define size (length q))
      (for ([i (in-range size)])
        (define curr (car q))
        (set! q (cdr q))

        (when (= curr (* n n))
          (return steps))

        (for ([dice (in-range 1 7)])
          (define next (+ curr dice))
          (when (<= next (* n n))
            (define coord (pos->coord next))
            (define next-pos (if (and (not (= (list-ref board (car coord) (cadr coord)) -1))
                                       (not (vector-ref visited next)))
                                 (list-ref board (car coord) (cadr coord))
                                 next))
            (when (not (vector-ref visited next-pos))
              (vector-set! visited next-pos #t)
              (set! q (append q (list next-pos)))))))
      (set! steps (+ steps 1)))
    -1))

(snakes-and-ladders [[-1,-1,-1,-1,-1,-1]
                     [-1,-1,-1,-1,-1,-1]
                     [-1,-1,-1,-1,-1,-1]
                     [-1,-1,-1,-1,-1,-1]
                     [-1,-1,-1,-1,-1,-1]
                     [-1,-1,-1,-1,-1,-1]])