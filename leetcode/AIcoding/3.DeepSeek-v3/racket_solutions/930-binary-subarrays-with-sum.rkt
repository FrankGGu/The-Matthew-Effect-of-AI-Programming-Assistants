(define/contract (num-subarrays-with-sum nums goal)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (define (at-most k)
    (if (< k 0) 0
        (let loop ([left 0] [right 0] [sum 0] [count 0])
          (if (>= right (length nums))
              count
              (let* ([sum (+ sum (list-ref nums right))]
                     [new-left (let inner ([left left] [sum sum])
                                 (if (> sum k)
                                     (inner (add1 left) (- sum (list-ref nums left)))
                                     left))]
                     [count (+ count (- right new-left -1))])
                (loop new-left (add1 right) sum count))))))
  (- (at-most goal) (at-most (- goal 1))))