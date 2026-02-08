(define (min-moves s)
  (define (solve s l r moves)
    (cond
      [(empty? s) moves]
      [(equal? (list-ref s 0) (list-ref s (- (length s) 1)))
       (solve (drop s 1) (+ l 1) (- r 1) moves)]
      [else
       (let loop ([i (- (length s) 2)])
         (cond
           [(< i 0) (solve (drop s 1) (+ l 1) (- r 1) (+ moves (- (length s) 1)))]
           [(equal? (list-ref s 0) (list-ref s i))
            (let ([temp (list-copy s)])
              (let loop2 ([j i])
                (cond
                  [(equal? j (- (length s) 1))
                   (solve (drop s 1) (+ l 1) (- r 1) (+ moves (- (- (length s) 1) i)))]
                  [else
                   (let ([t (list-ref temp (+ j 1))])
                     (list-set! temp (+ j 1) (list-ref temp j))
                     (list-set! temp j t)
                     (loop2 (+ j 1)))])))]
           [else (loop (- i 1))]))]))
  (solve (string->list s) 0 (- (string-length s) 1) 0))