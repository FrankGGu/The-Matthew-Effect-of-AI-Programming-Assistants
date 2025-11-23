(define (min-moves-to-capture-the-queen rookBishopPawn queen)
  (define (pos->pair pos)
    (list (quotient pos 8) (remainder pos 8)))

  (define (pair->pos row col)
    (+ (* row 8) col))

  (define (rook-moves rook queen)
    (let* ([rook-pos (pos->pair rook)]
           [queen-pos (pos->pair queen)]
           [rook-row (car rook-pos)]
           [rook-col (cadr rook-pos)]
           [queen-row (car queen-pos)]
           [queen-col (cadr queen-pos)])
      (if (or (= rook-row queen-row) (= rook-col queen-col))
          (let loop ([row rook-row] [col rook-col] [blocked #f])
            (cond
              [blocked #t]
              [(= row queen-row)
               (cond
                 [(< rook-col queen-col)
                  (for/and ([c (in-range (+ rook-col 1) queen-col)])
                    (not (member (pair->pos row c) rookBishopPawn))))
                 [(> rook-col queen-col)
                  (for/and ([c (in-range (+ queen-col 1) rook-col)])
                    (not (member (pair->pos row c) rookBishopPawn))))
                 [else #t])]
              [(= col queen-col)
               (cond
                 [(< rook-row queen-row)
                  (for/and ([r (in-range (+ rook-row 1) queen-row)])
                    (not (member (pair->pos r col) rookBishopPawn))))
                 [(> rook-row queen-row)
                  (for/and ([r (in-range (+ queen-row 1) rook-row)])
                    (not (member (pair->pos r col) rookBishopPawn))))
                 [else #t])]
              [else #f]))
          #f)))

  (define (bishop-moves bishop queen)
    (let* ([bishop-pos (pos->pair bishop)]
           [queen-pos (pos->pair queen)]
           [bishop-row (car bishop-pos)]
           [bishop-col (cadr bishop-pos)]
           [queen-row (car queen-pos)]
           [queen-col (cadr queen-pos)]
           [row-diff (- queen-row bishop-row)]
           [col-diff (- queen-col bishop-col)])
      (if (or (= row-diff col-diff) (= row-diff (- col-diff)))
          (let loop ([row bishop-row] [col bishop-col] [blocked #f])
            (cond
              [blocked #t]
              [(= row queen-row)
               (cond
                 [(and (> queen-row bishop-row) (> queen-col bishop-col))
                  (for/and ([i (in-range 1 (- queen-row bishop-row))])
                    (not (member (pair->pos (+ bishop-row i) (+ bishop-col i)) rookBishopPawn))))
                 [(and (> queen-row bishop-row) (< queen-col bishop-col))
                  (for/and ([i (in-range 1 (- queen-row bishop-row))])
                    (not (member (pair->pos (+ bishop-row i) (- bishop-col i)) rookBishopPawn))))
                 [(and (< queen-row bishop-row) (> queen-col bishop-col))
                  (for/and ([i (in-range 1 (- bishop-row queen-row))])
                    (not (member (pair->pos (- bishop-row i) (+ bishop-col i)) rookBishopPawn))))
                 [(and (< queen-row bishop-row) (< queen-col bishop-col))
                  (for/and ([i (in-range 1 (- bishop-row queen-row))])
                    (not (member (pair->pos (- bishop-row i) (- bishop-col i)) rookBishopPawn))))
                 [else #t])]
              [else #f]))
          #f)))

  (define (knight-moves knight queen)
    (let* ([knight-pos (pos->pair knight)]
           [queen-pos (pos->pair queen)]
           [knight-row (car knight-pos)]
           [knight-col (cadr knight-pos)]
           [queen-row (car queen-pos)]
           [queen-col (cadr queen-pos)])
      (if (and (<= 0 queen-row 7) (<= 0 queen-col 7)
               (or (and (= (abs (- knight-row queen-row)) 2) (= (abs (- knight-col queen-col)) 1))
                   (and (= (abs (- knight-row queen-row)) 1) (= (abs (- knight-col queen-col)) 2))))
          #t
          #f)))

  (let ([r (if (rook-moves (car rookBishopPawn) queen) 1 0)]
        [b (if (bishop-moves (cadr rookBishopPawn) queen) 1 0)])
    (min r b)))