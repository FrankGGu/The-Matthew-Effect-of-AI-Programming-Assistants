(define/contract (max-rook-sum grid)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (let* ([rows (length grid)]
         [cols (if (null? grid) 0 (length (car grid)))]
         [max-sum -inf.0])
    (for* ([i rows]
           [j cols]
           [k rows]
           [l cols]
           [m rows]
           [n cols])
      (when (and (not (or (= i k) (= j l)))
                 (not (or (= i m) (= j n)))
                 (not (or (= k m) (= l n))))
        (let ([sum (+ (list-ref (list-ref grid i) j)
                      (list-ref (list-ref grid k) l)
                      (list-ref (list-ref grid m) n))])
          (when (> sum max-sum)
            (set! max-sum sum)))))
    (if (= max-sum -inf.0) 0 max-sum)))