(define/contract (max-side-length mat threshold)
  (-> (listof (listof exact-integer?)) exact-integer? exact-integer?)
  (define m (length mat))
  (define n (if (null? mat) 0 (length (car mat))))
  (define prefix (make-vector (+ m 1) (make-vector (+ n 1) 0)))

  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (vector-set! (vector-ref prefix i) j
                   (+ (vector-ref (vector-ref (vector-ref prefix (- i 1)) j))
                      (vector-ref (vector-ref (vector-ref prefix i) (- j 1)))
                      (- (vector-ref (vector-ref (vector-ref prefix (- i 1)) (- j 1))))
                      (list-ref (list-ref mat (- i 1)) (- j 1))))))

  (define (get-sum x1 y1 x2 y2)
    (- (+ (vector-ref (vector-ref prefix x2) y2)
        (vector-ref (vector-ref prefix (- x1 1)) y2)
       (vector-ref (vector-ref prefix x2) (- y1 1))
       (vector-ref (vector-ref prefix (- x1 1)) (- y1 1)))))

  (define (binary-search left right x y)
    (if (> left right)
        0
        (let ([mid (quotient (+ left right) 2)])
          (if (<= (get-sum x y (+ x mid -1) (+ y mid -1)) threshold)
              (max mid (binary-search (+ mid 1) right x y))
              (binary-search left (- mid 1) x y)))))

  (define max-len 0)
  (for ([i (in-range 1 (+ m 1))])
    (for ([j (in-range 1 (+ n 1))])
      (set! max-len (max max-len (binary-search 1 (min (- m i -1) (- n j -1)) i j)))))

  max-len)