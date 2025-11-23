(define/contract (min-domino-rotations tops bottoms)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define (check x)
    (let loop ([i 0] [rot-top 0] [rot-bottom 0])
      (cond
        [(= i (length tops)) (min rot-top rot-bottom)]
        [(and (not (= (list-ref tops i) x)) (not (= (list-ref bottoms i) x))] -1)
        [(not (= (list-ref tops i) x)) (loop (add1 i) rot-top (add1 rot-bottom))]
        [(not (= (list-ref bottoms i) x)) (loop (add1 i) (add1 rot-top) rot-bottom)]
        [else (loop (add1 i) rot-top rot-bottom)])))
  (let ([res (check (car tops))]
        [res2 (check (car bottoms))])
    (cond
      [(and (= res -1) (= res2 -1)) -1]
      [(= res -1) res2]
      [(= res2 -1) res]
      [else (min res res2)])))