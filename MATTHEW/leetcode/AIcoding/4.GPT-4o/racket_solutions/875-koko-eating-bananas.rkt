(define (min-eating-speed piles h)
  (define (can-finish? k)
    (define total-hours  (apply + (map (lambda (p) (ceiling (/ p k))) piles)))
    (<= total-hours h))

  (define (binary-search left right)
    (if (= left right)
        left
        (let ((mid (quotient (+ left right) 2)))
          (if (can-finish? mid)
              (binary-search left mid)
              (binary-search (+ mid 1) right)))))

  (binary-search 1 (apply max piles)))

(define (koko-eating-bananas piles h)
  (min-eating-speed piles h))