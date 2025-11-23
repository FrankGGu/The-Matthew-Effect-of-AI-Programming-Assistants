(define (stone-game piles)
  (define (sum lst)
    (foldl + 0 lst))

  (define (helper piles start end m)
    (if (= start end)
        (list (car piles) 0)
        (let ([alice-score (make-vector (+ 1 n) (make-vector (+ 1 n) 0))]
              [bob-score (make-vector (+ 1 n) (make-vector (+ 1 n) 0))])

          (for ([i (in-range n)])
            (vector-set! (vector-ref alice-score i) i (list-ref piles i)))

          (for ([len (in-range 2 (+ 1 n))])
            (for ([i (in-range (- n len) 0 -1)])
              (let ([j (+ i len -1)])
                (let ([choose-left (if (> (list-ref piles i) (list-ref piles j))
                                       (+ (list-ref piles i) (vector-ref bob-score (+ i 1) j))
                                       (+ (list-ref piles j) (vector-ref bob-score i (- j 1))))
                      (choose-right (if (> (list-ref piles i) (list-ref piles j))
                                        (vector-ref alice-score (+ i 1) j)
                                        (vector-ref alice-score i (- j 1)))])
                  (if (> (list-ref piles i) (list-ref piles j))
                      (begin
                        (vector-set! (vector-ref alice-score i) j (+ (list-ref piles i) (vector-ref bob-score (+ i 1) j)))
                        (vector-set! (vector-ref bob-score i) j (vector-ref alice-score (+ i 1) j)))
                      (begin
                        (vector-set! (vector-ref alice-score i) j (+ (list-ref piles j) (vector-ref bob-score i (- j 1))))
                        (vector-set! (vector-ref bob-score i) j (vector-ref alice-score i (- j 1)))))))))

          (>= (vector-ref (vector-ref alice-score 0) (- n 1)) (/ (sum piles) 2.0))))

  (let ([n (length piles)])
    (helper piles 0 (- n 1) n))
  )