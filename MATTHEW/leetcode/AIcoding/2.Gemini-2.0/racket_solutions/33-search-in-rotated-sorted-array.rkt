(define (search nums target)
  (define (find-rotation nums)
    (let loop ([l 0] [r (- (length nums) 1)])
      (cond
        [(>= l r) l]
        [else
         (let* ([mid (floor (/ (+ l r) 2))]
                [mid-val (list-ref nums mid)]
                [r-val (list-ref nums r)])
           (if (> mid-val r-val)
               (loop (+ mid 1) r)
               (loop l (- mid 1))))])))

  (define (binary-search nums target l r)
    (cond
      [(>= l r)
       (if (= (list-ref nums l) target)
           l
           -1)]
      [else
       (let* ([mid (floor (/ (+ l r) 2))]
              [mid-val (list-ref nums mid)])
         (cond
           [(= mid-val target) mid]
           [(< target mid-val) (binary-search nums target l (- mid 1))]
           [else (binary-search nums target (+ mid 1) r)]))]))

  (let* ([n (length nums)]
         [rotation (find-rotation nums)])
    (if (= n 0)
        -1
        (if (= (list-ref nums rotation) target)
            rotation
            (if (and (>= rotation 0) (< target (list-ref nums 0)))
                (binary-search nums target (+ rotation 1) (- n 1))
                (binary-search nums target 0 (- rotation 1)))))))