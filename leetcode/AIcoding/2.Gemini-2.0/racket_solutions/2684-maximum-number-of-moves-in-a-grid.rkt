(define (max-moves grid)
  (define m (vector-length grid))
  (define n (vector-length (vector-ref grid 0)))
  (define dp (make-vector m 0))

  (define (valid-move? r c next-r next-c)
    (and (>= next-r 0) (< next-r m) (>= next-c 0) (< next-c n)
         (> (vector-ref (vector-ref grid next-r) next-c) (vector-ref (vector-ref grid r) c))))

  (define (solve r c)
    (if (= c (- n 1))
        0
        (let* ((moves (list))
               (next-c (+ c 1)))
          (when (valid-move? r c (- r 1) next-c)
            (set! moves (cons (+ 1 (solve (- r 1) next-c)) moves)))
          (when (valid-move? r c r next-c)
            (set! moves (cons (+ 1 (solve r next-c)) moves)))
          (when (valid-move? r c (+ r 1) next-c)
            (set! moves (cons (+ 1 (solve (+ r 1) next-c)) moves)))
          (if (null? moves)
              0
              (apply max moves)))))

  (let loop ((i 0) (max-move 0))
    (if (= i m)
        max-move
        (loop (+ i 1) (max max-move (solve i 0)))))
  )