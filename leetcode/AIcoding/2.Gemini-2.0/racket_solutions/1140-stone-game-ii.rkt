(define (stone-game-ii piles)
  (define n (length piles))
  (define prefix-sum (make-vector (+ n 1) 0))
  (for ([i (in-range 0 n)])
    (vector-set! prefix-sum (+ i 1) (+ (vector-ref prefix-sum i) (list-ref piles i))))

  (define memo (make-hash))

  (define (dfs i m)
    (cond
      [(>=? i n) 0]
      [(hash-has-key? memo (cons i m)) (hash-ref memo (cons i m))]
      [else
       (define max-score -inf.0)
       (for ([x (in-range 1 (+ (* 2 m) 1))])
         (when (<= (+ i x) n)
           (define score (- (vector-ref prefix-sum n) (vector-ref prefix-sum i) (dfs (+ i x) (max m x))))
           (set! max-score (max max-score score))))
       (hash-set! memo (cons i m) max-score)
       max-score]))

  (dfs 0 1))