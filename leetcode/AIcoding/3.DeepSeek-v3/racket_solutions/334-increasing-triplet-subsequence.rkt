(define/contract (increasing-triplet nums)
  (-> (listof exact-integer?) boolean?)
  (let loop ([first #f] [second #f] [rest nums])
    (cond
      [(null? rest) #f]
      [(not first) (loop (car rest) second (cdr rest))]
      [(not second) (if (> (car rest) first)
                        (loop first (car rest) (cdr rest))
                        (loop (car rest) second (cdr rest)))]
      [(> (car rest) second) #t]
      [else (if (> (car rest) first)
                (loop first (car rest) (cdr rest))
                (if (< (car rest) first)
                    (loop (car rest) second (cdr rest))
                    (loop first second (cdr rest)))])))