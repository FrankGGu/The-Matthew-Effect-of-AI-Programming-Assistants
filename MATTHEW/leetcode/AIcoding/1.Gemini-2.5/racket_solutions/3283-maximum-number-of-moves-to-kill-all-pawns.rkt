(define (maximum-number-of-moves-to-kill-all-pawns nums)
  (let* ([n (length nums)]
         [player-idx (let loop ([i 0])
                       (cond
                         [(= i n) -1] ; Should not happen if '1' is always present
                         [(= (list-ref nums i) 1) i]
                         [else (loop (+ i 1))]))]
         [right-pawns (let loop ([i (+ player-idx 1)] [count 0])
                        (cond
                          [(= i n) count]
                          [(= (list-ref nums i) -1) (loop (+ i 1) (+ count 1))]
                          [else (loop (+ i 1) count)]))]
         [left-pawns (let loop ([i (- player-idx 1)] [count 0])
                       (cond
                         [(< i 0) count]
                         [(= (list-ref nums i) -1) (loop (- i 1) (+ count 1))]
                         [else (loop (- i 1) count)]))])
    (max right-pawns left-pawns)))