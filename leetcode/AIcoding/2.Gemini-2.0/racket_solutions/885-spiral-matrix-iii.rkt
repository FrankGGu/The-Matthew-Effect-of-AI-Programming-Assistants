(define (spiral-matrix-iii rows cols r0 c0 T)
  (define (in-bounds? r c)
    (and (>= r 0) (< r rows) (>= c 0) (< c cols)))

  (define (solve r c dr dc count result)
    (cond
      [(>= count T) result]
      [(in-bounds? r c) (solve r c dr dc (add1 count) (append result (list (list r c))))]
      [else (solve r c dr dc count result)]))

  (let loop ([r r0] [c c0] [dr 0] [dc 1] [len 1] [count 0] [result '()])
    (cond
      [(>= count T) result]
      [else
       (let* ([new-result (solve r c dr dc count result)]
              [new-count (length new-result)]
              [next-dr (cond
                           [(= dr 0) (cond
                                        [(= dc 1) 1]
                                        [else -1])]
                           [else (cond
                                   [(= dr 1) 0]
                                   [else 0])]) ]
              [next-dc (cond
                           [(= dc 1) 0]
                           [(= dc -1) 0]
                           [(= dr 1) -1]
                           [else 1])]
              [next-len (if (or (= dr 0) (= dc 0)) len (add1 len))]
              [next-r (+ r (* len dr))]
              [next-c (+ c (* len dc))])
         (loop next-r next-c next-dr next-dc next-len new-count new-result))]))))

(define (spiral-matrix rows cols r0 c0)
  (spiral-matrix-iii rows cols r0 c0 (* rows cols)))