(define (is-winner player1 player2)
  (define (score rolls)
    (let loop ([i 0] [sum 0])
      (if (>= i (length rolls))
          sum
          (let ([strike? (and (< i (- (length rolls) 2)) (= (list-ref rolls i) 10))]
                [spare? (and (< i (- (length rolls) 2)) (= (+ (list-ref rolls i) (list-ref rolls (+ i 1))) 10))])
            (cond
              [strike? (loop (+ i 1) (+ sum 10 (list-ref rolls (+ i 1)) (list-ref rolls (+ i 2))))]
              [spare? (loop (+ i 2) (+ sum 10 (list-ref rolls (+ i 2))))]
              [else (loop (+ i 1) (+ sum (list-ref rolls i))])))))
  (let ([s1 (score player1)]
        [s2 (score player2)])
    (cond
      [(> s1 s2) 1]
      [(< s1 s2) 2]
      [else 0])))