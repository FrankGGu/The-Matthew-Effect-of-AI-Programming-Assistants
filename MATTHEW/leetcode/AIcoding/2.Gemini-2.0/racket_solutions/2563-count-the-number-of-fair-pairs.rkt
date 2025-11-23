(define (count-fair-pairs nums lower upper)
  (define sorted-nums (sort nums <))
  (let loop ([i 0] [count 0])
    (if (= i (length sorted-nums))
        count
        (let ([left (let search ([l 0] [r (- (length sorted-nums) 1)])
                      (cond
                        [(> l r) l]
                        [else
                         (let ([mid (floor (+ l r) 2)])
                           (cond
                             [(>= (+ (list-ref sorted-nums i) (list-ref sorted-nums mid)) lower)
                              (search l (- mid 1))]
                             [else
                              (search (+ mid 1) r)]))]))]
              [right (let search ([l 0] [r (- (length sorted-nums) 1)])
                       (cond
                         [(> l r) r]
                         [else
                          (let ([mid (floor (+ l r) 2)])
                            (cond
                              [(<= (+ (list-ref sorted-nums i) (list-ref sorted-nums mid)) upper)
                               (search (+ mid 1) r)]
                              [else
                               (search l (- mid 1))]))]))])
          (loop (+ i 1) (+ count (max 0 (- right left - (if (and (>= i left) (<= i right)) 1 0)))))))))