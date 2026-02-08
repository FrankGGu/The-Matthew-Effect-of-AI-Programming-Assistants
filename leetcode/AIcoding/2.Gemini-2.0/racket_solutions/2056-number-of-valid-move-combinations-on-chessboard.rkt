(define (number-of-valid-move-combinations chessboard)
  (define n (vector-length chessboard))
  (define pieces (vector-length (vector-ref chessboard 0)))
  (define (valid-move? start end moves)
    (cond
      [(empty? moves) #t]
      [else
       (let* ((piece-type (car moves))
              (start-row (vector-ref start 0))
              (start-col (vector-ref start 1))
              (end-row (vector-ref end 0))
              (end-col (vector-ref end 1))
              (row-diff (- end-row start-row))
              (col-diff (- end-col start-col))
              (row-abs (abs row-diff))
              (col-abs (abs col-diff)))
         (cond
           [(and (= piece-type 1) (= row-diff 0) (= col-diff 0)) #f]
           [(and (= piece-type 2) (= row-diff 0) (= col-diff 0)) #f]
           [(and (= piece-type 3) (= row-diff 0) (= col-diff 0)) #f]
           [(and (= piece-type 1) (or (not (= row-diff 0)) (not (= col-diff 0)))
                 (or (not (= row-abs col-abs)) (not (= row-abs 1)))) #f]
           [(and (= piece-type 2) (or (not (= row-diff 0)) (not (= col-diff 0)))
                 (or (not (= row-diff 0)) (not (= col-diff 0)))
                 (or (and (= row-diff 0) (= col-diff 0)) (> (max row-abs col-abs) 1))) #f]
           [(and (= piece-type 3) (or (not (= row-diff 0)) (not (= col-diff 0)))
                 (or (not (= row-diff 0)) (not (= col-diff 0)))
                 (or (and (= row-diff 0) (= col-diff 0)) (> (max row-abs col-abs) 1))) #f]
           [else #t]))]))

  (define (check-path start end moves)
    (cond
      [(empty? moves) #t]
      [else
       (let* ((piece-type (car moves))
              (start-row (vector-ref start 0))
              (start-col (vector-ref start 1))
              (end-row (vector-ref end 0))
              (end-col (vector-ref end 1))
              (row-diff (- end-row start-row))
              (col-diff (- end-col start-col))
              (row-abs (abs row-diff))
              (col-abs (abs col-diff))
              (row-step (if (= row-diff 0) 0 (/ row-diff row-abs)))
              (col-step (if (= col-diff 0) 0 (/ col-diff col-abs))))
         (let loop ((row (+ start-row row-step)) (col (+ start-col col-step)))
           (cond
             [(and (= row end-row) (= col end-col)) #t]
             [(or (< row 0) (>= row n) (< col 0) (>= col n)) #f]
             [else
              (let ((is-blocked (ormap (lambda (piece)
                                          (let ((piece-pos (vector-ref (vector-ref chessboard 0) piece)))
                                            (and (= (vector-ref piece-pos 0) row) (= (vector-ref piece-pos 1) col)))))
                                        (range pieces))))
                (if is-blocked #f (loop (+ row row-step) (+ col col-step)))))])))]))

  (define (count-combinations positions moves)
    (cond
      [(empty? positions) 1]
      [else
       (let ((piece-index (car positions)))
         (let loop ((i 0) (count 0))
           (if (= i n)
               count
               (let loop2 ((j 0))
                 (if (= j n)
                     (loop (+ i 1) count)
                     (let* ((start-pos (vector-ref (vector-ref chessboard 0) piece-index))
                            (end-pos (vector (vector i j) (vector i j)))
                            (valid (and (valid-move? start-pos (vector i j) moves)
                                        (check-path start-pos (vector i j) moves))))
                       (if valid
                           (let ((new-chessboard (copy-vector chessboard)))
                             (vector-set! (vector-ref new-chessboard 0) piece-index (vector i j))
                             (let ((new-positions (filter (lambda (p) (not (= p piece-index))) positions)))
                               (loop2 (+ j 1))
                               (loop (+ i 1) (+ count (count-combinations new-positions moves)))))
                           (loop2 (+ j 1))
                           (loop (+ i 1) count))))))))]))

  (define (solve)
    (let ((all-moves (list (list 1 1 1) (list 2 2 2) (list 3 3 3))))
      (apply + (map (lambda (moves) (count-combinations (range pieces) moves)) all-moves))))
  (solve))