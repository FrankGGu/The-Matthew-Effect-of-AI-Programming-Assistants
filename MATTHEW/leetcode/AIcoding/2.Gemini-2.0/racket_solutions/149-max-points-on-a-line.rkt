(define (max-points points)
  (let ([n (length points)])
    (if (<= n 2)
        n
        (let loop ([i 0] [max-count 0])
          (if (= i n)
              max-count
              (let* ([x1 (car (list-ref points i))]
                     [y1 (cadr (list-ref points i))]
                     [slopes (make-hash)])
                (let slope-loop ([j (add1 i)] [vertical 0] [same 1])
                  (if (= j n)
                      (let ([max-slope (if (hash-empty? slopes)
                                          0
                                          (apply max (hash-values slopes)))])
                         (loop (add1 i) (max max-count (+ same (max vertical max-slope)))))
                      (let* ([x2 (car (list-ref points j))]
                             [y2 (cadr (list-ref points j))])
                        (cond
                          [(= x1 x2)
                           (cond
                             [(= y1 y2)
                              (slope-loop (add1 j) vertical (add1 same))]
                             [else
                              (slope-loop (add1 j) (add1 vertical) same)])]
                          [else
                           (let ([slope (/ (- y2 y1) (- x2 x1))])
                             (hash-update! slopes slope (lambda (v) (add1 v)) 1)
                             (slope-loop (add1 j) vertical same))]))))))))))