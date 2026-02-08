(define (minimum-area grid)
  (let* ([m (length grid)]
         [n (if (null? grid) 0 (length (car grid)))]
         [min-r m]
         [max-r -1]
         [min-c n]
         [max-c -1])
    (for ([r (in-range m)])
      (for ([c (in-range n)])
        (when (char=? #\1 (list-ref (list-ref grid r) c))
          (set! min-r (min min-r r))
          (set! max-r (max max-r r))
          (set! min-c (min min-c c))
          (set! max-c (max max-c c)))))
    (if (= max-r -1)
        0
        (* (+ (- max-r min-r) 1)
           (+ (- max-c min-c) 1)))))