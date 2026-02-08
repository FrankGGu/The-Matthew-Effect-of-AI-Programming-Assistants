(define (find-radius houses heaters)
  (define (binary-search arr target)
    (let loop ([low 0] [high (- (length arr) 1)])
      (cond
        [(> low high) low]
        [else
         (let* ([mid (floor (/ (+ low high) 2))]
                [mid-val (list-ref arr mid)])
           (cond
             [(< mid-val target) (loop (+ mid 1) high)]
             [else (loop low (- mid 1))]))])))

  (define (min-radius house)
    (let* ([pos (binary-search heaters house)]
           [dist1 (if (= pos 0) +inf.0 (- house (list-ref heaters (- pos 1))))]
           [dist2 (if (= pos (length heaters)) +inf.0 (- (list-ref heaters pos) house))])
      (min dist1 dist2)))

  (apply max (map min-radius houses)))