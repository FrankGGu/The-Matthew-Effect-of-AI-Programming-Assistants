(define (count-cells grid)
  (define rows (length grid))
  (define cols (length (car grid)))

  (define (count-overlapping-cells)
    (let loop ([i 0] [count 0])
      (if (= i rows)
          count
          (let loop2 ([j (add1 i)] [count2 count])
            (if (= j rows)
                (loop (add1 i) count2)
                (let ([overlap-count (count-horizontal-overlap (list-ref grid i) (list-ref grid j))])
                  (loop2 (add1 j) (+ count2 overlap-count))))))))

  (define (count-horizontal-overlap row1 row2)
    (let loop ([i 0] [count 0])
      (if (= i cols)
          count
          (if (and (= (list-ref row1 i) 1) (= (list-ref row2 i) 1))
              (loop (add1 i) (add1 count))
              (loop (add1 i) count)))))

  (define (count-vertical-overlap col1 col2)
    (let loop ([i 0] [count 0])
      (if (= i rows)
          count
          (if (and (= (list-ref (list-ref grid i) col1) 1) (= (list-ref (list-ref grid i) col2) 1))
              (loop (add1 i) (add1 count))
              (loop (add1 i) count)))))

  (define (count-overlapping-cols)
    (let loop ([i 0] [count 0])
      (if (= i cols)
          count
          (let loop2 ([j (add1 i)] [count2 count])
            (if (= j cols)
                (loop (add1 i) count2)
                (let ([overlap-count (count-vertical-overlap i j)])
                  (loop2 (add1 j) (+ count2 overlap-count))))))))

  (+ (count-overlapping-cells) (count-overlapping-cols)))