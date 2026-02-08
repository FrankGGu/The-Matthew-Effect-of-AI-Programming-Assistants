(define (minFlips grid)
  (define n (vector-length grid))
  (define m (vector-length (vector-ref grid 0)))

  (define (is-palindrome? row)
    (let loop ([left 0] [right (- m 1)])
      (cond
        [(>= left right) #t]
        [(= (vector-ref row left) (vector-ref row right)) (loop (+ left 1) (- right 1))]
        [else #f])))

  (define (flip-row row index)
    (vector-set! row index (if (= (vector-ref row index) 0) 1 0)))

  (define (check-all-rows mask)
    (let ([new-grid (make-vector n (make-vector m 0))])
      (for ([i (in-range n)])
        (for ([j (in-range m)])
          (vector-set! (vector-ref new-grid i) j (vector-ref (vector-ref grid i) j))))

      (for ([i (in-range n)])
        (when (bitwise-bit-set? mask i)
          (for ([j (in-range m)])
            (flip-row (vector-ref new-grid i) j))))

      (let loop ([i 0])
        (cond
          [(= i n) #t]
          [(is-palindrome? (vector-ref new-grid i)) (loop (+ i 1))]
          [else #f]))))

  (let loop ([mask 0] [min-flips #f])
    (cond
      [(>= mask (expt 2 n)) min-flips]
      [else
       (let ([flips (for/sum ([i (in-range n)])
                        (if (bitwise-bit-set? mask i) m 0))])
         (if (check-all-rows mask)
             (loop (+ mask 1) (cond [(not min-flips) flips] [(< flips min-flips) flips] [else min-flips]))
             (loop (+ mask 1) min-flips)))

       ])))