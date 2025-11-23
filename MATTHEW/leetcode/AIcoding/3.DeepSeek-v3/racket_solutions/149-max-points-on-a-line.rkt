(define/contract (max-points points)
  (-> (listof (listof exact-integer?)) exact-integer?)
  (define n (length points))
  (if (<= n 2) n
      (let loop ([i 0] [max-count 2])
        (if (>= i (- n 1)) max-count
            (let ([slopes (make-hash)] [duplicate 1] [current-max 0])
              (for ([j (in-range (+ i 1) n)])
                (let* ([x1 (first (list-ref points i))]
                       [y1 (second (list-ref points i))]
                       [x2 (first (list-ref points j))]
                       [y2 (second (list-ref points j))])
                  (cond [(and (= x1 x2) (= y1 y2)) (set! duplicate (add1 duplicate))]
                        [(= x1 x2) (hash-update! slopes 'inf (lambda (v) (add1 v)) 1)]
                        [else (let* ([dx (- x1 x2)]
                                     [dy (- y1 y2)]
                                     [gcd-val (gcd dx dy)]
                                     [slope (cons (/ dx gcd-val) (/ dy gcd-val))])
                                (hash-update! slopes slope (lambda (v) (add1 v)) 1)]))))
              (set! current-max (apply max (cons 0 (hash-values slopes))))
              (loop (add1 i) (max max-count (+ current-max duplicate)))))))