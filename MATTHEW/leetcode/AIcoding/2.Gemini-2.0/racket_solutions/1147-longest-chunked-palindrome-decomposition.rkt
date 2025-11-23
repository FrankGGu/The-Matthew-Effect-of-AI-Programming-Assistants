(define (longest-decomposition text)
  (let loop ([l 0] [r (- (string-length text) 1)] [count 0])
    (cond
      [(> l r) count]
      [(= l r) (+ count 1)]
      [else
       (let loop2 ([len 1])
         (cond
           [(> (+ l len -1) (- r len + 1)) (+ count 1)]
           [else
            (if (string=? (substring text l (+ l len)) (substring text (- r len + 1) (+ r 1)))
                (loop (+ l len) (- r len) (+ count 2))
                (loop2 (+ len 1)))]))]))))