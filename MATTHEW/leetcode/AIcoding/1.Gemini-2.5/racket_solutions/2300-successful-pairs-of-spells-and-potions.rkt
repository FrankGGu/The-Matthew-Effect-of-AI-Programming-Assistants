(define (binary-search-lower-bound arr target)
  (let* ([n (vector-length arr)])
    (let loop ([low 0] [high n] [ans n])
      (if (< low high)
          (let* ([mid (+ low (quotient (- high low) 2))]
                 [val (vector-ref arr mid)])
            (if (>= val target)
                (loop low mid mid)
                (loop (+ mid 1) high ans)))
          ans))))

(define (successful-pairs spells potions success)
  (let* ([sorted-potions (vector-sort < (list->vector potions))]
         [n-potions (vector-length sorted-potions)])
    (map (lambda (s)
           (let* ([min-required-potion (ceiling (/ success s))]
                  [idx (binary-search-lower-bound sorted-potions min-required-potion)])
             (- n-potions idx)))
         spells)))