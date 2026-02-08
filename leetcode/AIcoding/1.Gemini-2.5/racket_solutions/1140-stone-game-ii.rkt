(define (stoneGameII piles-list)
  (define piles (list->vector piles-list))
  (define n (vector-length piles))

  (define suffix-sums (make-vector n))
  (define current-sum 0)
  (for ([idx (in-range (- n 1) -1 -1)])
    (set! current-sum (+ current-sum (vector-ref piles idx)))
    (vector-set! suffix-sums idx current-sum))

  (define memo-table (make-vector n))
  (for ([i (in-range n)])
    (vector-set! memo-table i (make-vector (+ n 1) #f)))

  (define (solve i m)
    (if (>= i n)
        0
        (let ([memoized-val (vector-ref (vector-ref memo-table i) m)])
          (if memoized-val
              memoized-val
              (let* ([current-suffix-sum (vector-ref suffix-sums i)])
                (let loop ([x 1] [current-max 0])
                  (if (> x (* 2 m))
                      (begin
                        (vector-set! (vector-ref memo-table i) m current-max)
                        current-max)
                      (if (>= (+ i x) n)
                          (begin
                            (vector-set! (vector-ref memo-table i) m current-suffix-sum)
                            current-suffix-sum)
                          (let* ([next-m (max m x)]
                                 [stones-opponent-gets (solve (+ i x) next-m)]
                                 [stones-current-player-gets-from-this-move (- current-suffix-sum stones-opponent-gets)])
                            (loop (add1 x) (max current-max stones-current-player-gets-from-this-move))))))))))

  (solve 0 1))