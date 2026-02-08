(define (maxSatisfaction satisfaction)
  (define sorted-satisfaction (sort satisfaction >))
  (define (helper idx time acc sum)
    (if (or (>= idx (length sorted-satisfaction)) (< sum 0))
        acc
        (let ((new-acc (+ acc (* time (list-ref sorted-satisfaction idx)))))
          (helper (+ idx 1) (+ time 1) new-acc (+ sum (list-ref sorted-satisfaction idx))))))
  (helper 0 1 0 0))