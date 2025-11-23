(define (minimizedMaximum n quantities)
  (define (can-distribute max)
    (define stores (apply + (map (lambda (x) (ceiling (/ x max))) quantities)))
    (<= stores n))

  (define min 1)
  (define max (apply max quantities))

  (define (binary-search low high)
    (if (= low high)
        low
        (let ((mid (quotient (+ low high) 2)))
          (if (can-distribute mid)
              (binary-search low mid)
              (binary-search (add1 mid) high)))))

  (binary-search min max))

(minimizedMaximum n quantities)