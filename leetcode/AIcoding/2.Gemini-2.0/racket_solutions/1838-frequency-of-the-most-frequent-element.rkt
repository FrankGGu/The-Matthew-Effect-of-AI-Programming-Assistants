(define (max-frequency nums k)
  (define (solve nums k)
    (define (count-max-frequency sorted-nums k)
      (let loop ([left 0] [right 0] [current-sum 0] [max-frequency 0])
        (cond
          [(>= right (length sorted-nums)) max-frequency]
          [else
           (let ([current-sum (+ current-sum (list-ref sorted-nums right))])
             (let loop2 ([left left] [current-sum current-sum])
               (cond
                 [(>= left right)
                  (loop (+ right 1) (+ right 1) current-sum (max max-frequency (- right left 0)))]
                 [else
                  (if (<= (+ k (* (list-ref sorted-nums right) (- right left)) (- current-sum)) 0)
                      (loop2 (+ left 1) (- current-sum (list-ref sorted-nums left))))
                  (loop (+ right 1) (+ right 1) current-sum (max max-frequency (- right left 0))))])))])))
    (count-max-frequency (sort nums <) k))
  (solve nums k))