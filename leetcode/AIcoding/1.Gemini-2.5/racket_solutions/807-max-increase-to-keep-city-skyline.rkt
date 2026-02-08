(define (max-increase-to-keep-skyline grid)
  (define num-rows (length grid))
  (define num-cols (length (car grid))) ; Assumes grid is non-empty and rectangular

  ; Calculate row-maxes: the maximum height in each row
  (define row-maxes
    (for/list ((row grid))
      (apply max row)))

  ; Calculate col-maxes: the maximum height in each column
  (define col-maxes
    (for/list ((j (range num-cols)))
      (apply max (for/list ((i (range num-rows)))
                   (list-ref (list-ref grid i) j)))))

  ; Calculate the total increase
  (for/sum ((i (range num-rows))
            (j (range num-cols)))
    (define current-height (list-ref (list-ref grid i) j))
    (define max-allowed-height (min (list-ref row-maxes i)
                                    (list-ref col-maxes j)))
    (- max-allowed-height current-height)))