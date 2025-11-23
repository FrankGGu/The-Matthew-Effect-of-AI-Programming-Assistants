(define (magic-board board)
  (define (is-valid? x y)
    (and (>= x 0) (< x (length board))
         (>= y 0) (< y (length (list-ref board 0)))))

  (define (dfs x y visited)
    (if (and (is-valid? x y) (not (memv (list x y) visited)))
        (let ((new-visited (cons (list x y) visited)))
          (if (and (= (length new-visited) (* (length board) (length (list-ref board 0))))
                   (not (memv (list x y) new-visited)))
              (begin
                (set! visited new-visited)
                (for/fold ([count 0]) ([dx (list -1 1 0 0)] [dy (list 0 0 -1 1)])
                  (+ count (dfs (+ x dx) (+ y dy) new-visited))))
              0))
        0))

  (dfs 0 0 '()))

(define board '((0 0 0) (0 0 0) (0 0 0)))
(magic-board board)