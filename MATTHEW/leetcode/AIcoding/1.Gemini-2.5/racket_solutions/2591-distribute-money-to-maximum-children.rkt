(define (distribute-money money children)
  (cond
    ((< money children) 0) ; Not enough money to give each child at least $1
    (else
     (let loop ((k (min children (quotient money 8)))) ; Iterate k (number of children getting $8) downwards
       (cond
         ((< k 0) 0) ; If k goes below 0, no valid k was found
         (else
          (let* ((remaining-money (- money (* k 8)))
                 (remaining-children (- children k)))
            (if (>= remaining-money remaining-children) ; Check if remaining children can each get at least $1
                (if (and (= remaining-children 1) (= remaining-money 4))
                    (loop (- k 1)) ; This k is invalid because one child would get exactly $4
                    k)             ; This k is valid, return it (since we iterate downwards, this is the maximum)
                (loop (- k 1)))))))))) ; Not enough money for remaining children, try a smaller k