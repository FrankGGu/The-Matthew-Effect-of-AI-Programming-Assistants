(define (maximize-square-hole-area n m h-bars v-bars)
  (define (max-consecutive bars)
    (let loop ([bars (sort bars <)] [count 1] [max-count 1] [prev -2])
      (cond
        [(empty? bars) max-count]
        [(> (first bars) (+ prev 1)) (loop (rest bars) 1 max-count (first bars))]
        [else (let ([new-count (+ count 1)])
                (loop (rest bars) new-count (max max-count new-count) (first bars)))])))
  (define h-len (+ 1 (max-consecutive h-bars)))
  (define v-len (+ 1 (max-consecutive v-bars)))
  (expt (min h-len v-len) 2))