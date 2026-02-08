(define (check-valid-string s)
  (define (helper s lo hi)
    (cond
      [(empty? s) (<= lo 0 hi)]
      [(char=? (first s) #\() (helper (rest s) (+ lo 1) (+ hi 1))]
      [(char=? (first s) #\)) (cond
                                  [(= lo 0) (helper (rest s) lo (- hi 1))]
                                  [else (helper (rest s) (- lo 1) (- hi 1))])]
      [else (cond
              [(= lo 0) (helper (rest s) lo (+ hi 1))]
              [else (or (helper (rest s) (+ lo 1) (+ hi 1))
                        (helper (rest s) (- lo 1) (- hi 1))
                        (helper (rest s) lo hi))])]))
  (helper (string->list s) 0 0))