(define (longest-semi-repetitive s)
  (define n (string-length s))
  (if (<= n 2)
      n
      (let loop ([left 0] [right 1] [count 0] [max-len 1])
        (cond
          [(>= right n) (max max-len (- right left))]
          [(char=? (string-ref s right) (string-ref s (sub1 right)))
           (if (< count 1)
               (loop left (add1 right) (add1 count) max-len)
               (let ([new-left (let find-left ([l left])
                                 (if (char=? (string-ref s l) (string-ref s (add1 l)))
                                     (add1 l)
                                     (find-left (add1 l))))])
                 (loop new-left right count (max max-len (- right left)))))]
          [else
           (loop left (add1 right) count (max max-len (- (add1 right) left)))]))))