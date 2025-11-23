(define (robot-reach targetX targetY command obstacles)
  (let* ([n (string-length command)]
         [path-points (let loop ([i 0] [curr-x 0] [curr-y 0] [acc (list (cons 0 0))])
                        (if (= i n)
                            (reverse acc)
                            (let ([char (string-ref command i)])
                              (case char
                                [(#\U) (loop (add1 i) curr-x (add1 curr-y) (cons (cons curr-x (add1 curr-y)) acc))]
                                [(#\D) (loop (add1 i) curr-x (sub1 curr-y) (cons (cons curr-x (sub1 curr-y)) acc))]
                                [(#\L) (loop (add1 i) (sub1 curr-x) curr-y (cons (cons (sub1 curr-x) curr-y) acc))]
                                [(#\R) (loop (add1 i) (add1 curr-x) curr-y (cons (cons (add1 curr-x) curr-y) acc))]
                                [else (error "Invalid command char")]))))]
         [cycle-dx (car (last path-points))]
         [cycle-dy (cdr (last path-points))]
         [max-possible-time (expt 10 12)] ; A sufficiently large number for +inf
         )

    (define (is-reachable-at-time tx ty)
      (let loop ([j 0] [min-time max-possible-time])
        (if (> j n)
            (if (= min-time max-possible-time) #f min-time)
            (let* ([offset-point (list-ref path-points j)]
                   [x-offset (car offset-point)]
                   [y-offset (cdr offset-point)]
                   [dx-rem (- tx x-offset)]
                   [dy-rem (- ty y-offset)]
                   [current-k -1])

              (cond
                [(and (= cycle-dx 0) (= cycle-dy 0))
                 (when (and (= dx-rem 0) (= dy-rem 0))
                   (set! current-k 0))]

                [(= cycle-dx 0)
                 (when (and (= dx-rem 0)
                            (zero? (remainder dy-rem cycle-dy)))
                   (let ([k-candidate (quotient dy-rem cycle-dy)])
                     (when (>= k-candidate 0)
                       (set! current-k k-candidate))))]

                [(= cycle-dy 0)
                 (when (and (= dy-rem 0)
                            (zero? (remainder dx-rem cycle-dx)))
                   (let ([k-candidate (quotient dx-rem cycle-dx)])
                     (when (>= k-candidate 0)
                       (set! current-k k-candidate))))]

                [else
                 (when (and (zero? (remainder dx-rem cycle-dx))
                            (zero? (remainder dy-rem cycle-dy)))
                   (let ([k-x (quotient dx-rem cycle-dx)]
                         [k-y (quotient dy-rem cycle-dy)])
                     (when (and (>= k-x 0) (= k-x k-y))
                       (set! current-k k-x))))])

              (if (>= current-k 0)
                  (loop (add1 j) (min min-time (+ (* current-k n) j)))
                  (loop (add1 j) min-time))))))

    (let ([target-actual-time (is-reachable-at-time targetX targetY)])
      (if (not target-actual-time)
          #f
          (let loop-obstacles ([obs-list obstacles])
            (if (null? obs-list)
                #t
                (let* ([obs (car obs-list)]
                       [ox (car obs)]
                       [oy (cadr obs)]
                       [obstacle-actual-time (is-reachable-at-time ox oy)])
                  (if (and obstacle-actual-time (<= obstacle-actual-time target-actual-time))
                      #f
                      (loop-obstacles (cdr obs-list))))))))))