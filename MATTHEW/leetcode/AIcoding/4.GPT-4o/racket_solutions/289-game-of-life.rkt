(define (game-of-life board)
  (define rows (length board))
  (define cols (length (car board)))
  (define (count-live-neighbors r c)
    (define directions '((-1 -1) (-1 0) (-1 1) (0 -1) (0 1) (1 -1) (1 0) (1 1)))
    (define (in-bounds? r c)
      (and (>= r 0) (< r rows) (>= c 0) (< c cols)))
    (apply + (map (lambda (d)
                    (let ((nr (+ r (car d)))
                          (nc (+ c (cadr d))))
                      (if (and (in-bounds? nr nc) (= 1 (list-ref (list-ref board nr) nc)))
                          1
                          0)))
                  directions)))

  (define new-board
    (for/list ([r (in-range rows)])
      (for/list ([c (in-range cols)])
        (let ((live-neighbors (count-live-neighbors r c)))
          (cond
            [(= 1 (list-ref (list-ref board r) c)) ; current cell is live
             (if (or (= live-neighbors 2) (= live-neighbors 3)) 1 0)]
            [(= 0 (list-ref (list-ref board r) c)) ; current cell is dead
             (if (= live-neighbors 3) 1 0)])))))

  (for ([r (in-range rows)] [c (in-range cols)])
    (set! (list-ref (list-ref board r) c) (list-ref (list-ref new-board r) c))))
  board)