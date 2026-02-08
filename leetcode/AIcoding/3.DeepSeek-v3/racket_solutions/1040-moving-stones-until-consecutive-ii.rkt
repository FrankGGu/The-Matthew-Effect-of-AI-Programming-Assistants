(define/contract (num-moves-stones-ii stones)
  (-> (listof exact-integer?) (listof exact-integer?))
  (let* ([stones (sort stones <)]
         [n (length stones)]
         [max-moves (max (- (list-ref stones (- n 1)) (list-ref stones 1) (- n 2))
                         (- (list-ref stones (- n 2)) (list-ref stones 0) (- n 2)))]
         [min-moves n]
         [i 0])
    (for ([j (in-range n)])
      (let loop ()
        (when (and (< i n) (< (list-ref stones i) (+ (list-ref stones j) n)))
          (set! i (+ i 1))
          (loop)))
      (let ([cost (- n (- i j))])
        (when (and (= cost 1) (= (- (list-ref stones i) (list-ref stones j)) (- n 1)))
          (set! cost 2))
        (set! min-moves (min min-moves cost))))
    (list min-moves max-moves)))