(define (min-flips grid)
  (let* ([n (length grid)]
         [m (length (first grid))]
         [total 0])
    (for ([i (in-range (quotient n 2))])
      (for ([j (in-range (quotient m 2))])
        (let* ([a (list-ref (list-ref grid i) j)]
               [b (list-ref (list-ref grid i) (- m j 1))]
               [c (list-ref (list-ref grid (- n i 1)) j)]
               [d (list-ref (list-ref grid (- n i 1)) (- m j 1))])
          (let ([count (+ (if (equal? a 1) 1 0)
                          (if (equal? b 1) 1 0)
                          (if (equal? c 1) 1 0)
                          (if (equal? d 1) 1 0))])
            (set! total (+ total (min count (- 4 count)))))))
    (if (odd? n)
        (let ([mid-row (quotient n 2)])
          (for ([j (in-range (quotient m 2))])
            (let ([a (list-ref (list-ref grid mid-row) j)]
                  [b (list-ref (list-ref grid mid-row) (- m j 1))])
              (when (not (equal? a b))
                (set! total (+ total 1))))))
    (if (odd? m)
        (let ([mid-col (quotient m 2)])
          (for ([i (in-range (quotient n 2))])
            (let ([a (list-ref (list-ref grid i) mid-col)]
                  [b (list-ref (list-ref grid (- n i 1)) mid-col)])
              (when (not (equal? a b))
                (set! total (+ total 1))))))
    total))