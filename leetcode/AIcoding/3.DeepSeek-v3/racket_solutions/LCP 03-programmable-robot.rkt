(define (robot command obstacles x y)
  (let loop ((i 0) (pos-x 0) (pos-y 0) (dir 0))
    (cond
      [(and (= pos-x x) (= pos-y y)) #t]
      [(or (>= i (string-length command)) 
           (member (list pos-x pos-y) obstacles)) #f]
      [else
       (let ((cmd (string-ref command i)))
         (case cmd
           [(#\G)
            (let-values ([(dx dy) 
                          (case dir
                            [(0) (values 1 0)]
                            [(1) (values 0 1)]
                            [(2) (values -1 0)]
                            [(3) (values 0 -1)])])
              (loop (add1 i) (+ pos-x dx) (+ pos-y dy) dir))]
           [(#\R)
            (loop (add1 i) pos-x pos-y (modulo (add1 dir) 4))]
           [(#\L)
            (loop (add1 i) pos-x pos-y (modulo (sub1 dir) 4))])))])))