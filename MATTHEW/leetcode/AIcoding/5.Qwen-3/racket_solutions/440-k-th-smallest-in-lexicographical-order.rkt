(define (find-kth-number n k)
  (define (count-steps n curr next)
    (let loop ([curr curr] [next next] [steps 0])
      (if (> curr n)
          steps
          (loop (* curr 10) (* next 10) (+ steps (- next curr) 1)))))

  (define (find-kth n k)
    (let loop ([curr 1] [k k])
      (if (= k 1)
          curr
          (let* ([steps (count-steps n curr (* curr 10))]
                 [k (if (<= k steps) k (- k steps))])
            (loop (* curr 10) k)))))

  (find-kth n k))