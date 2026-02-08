(define (findKthNumber n k)
  (let loop ([current 1] [k k])
    (cond
      [(= k 1) current]
      [else
       (let* ([steps (count-steps current n)]
              [next-k (- k steps)])
         (if (<= next-k 0)
             (loop (* current 10) (sub1 k))
             (loop (add1 current) next-k)))])))

(define (count-steps current n)
  (let loop ([first current] [last current] [steps 0])
    (if (> first n)
        steps
        (loop (* first 10) (min n (add1 (* last 10))) (+ steps (- (min n last) first -1))))))