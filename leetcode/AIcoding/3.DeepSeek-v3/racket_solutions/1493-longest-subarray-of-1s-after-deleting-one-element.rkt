(define/contract (longest-subarray nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [count 0] [max-len 0] [nums nums])
    (cond
      [(>= right (length nums)) (if (> max-len 0) (- max-len 1) 0)]
      [(= (list-ref nums right) 1) (loop left (+ right 1) count (max max-len (- (+ right 1) left)) nums)]
      [else (if (= count 0)
                (loop left (+ right 1) 1 max-len nums)
                (if (= (list-ref nums left) 0)
                    (loop (+ left 1) right count max-len nums)
                    (loop (+ left 1) right count max-len nums)))])))