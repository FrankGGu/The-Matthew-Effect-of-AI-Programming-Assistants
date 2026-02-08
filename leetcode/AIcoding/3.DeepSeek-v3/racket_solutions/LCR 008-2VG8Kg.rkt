(define/contract (min-sub-array-len target nums)
  (-> exact-integer? (listof exact-integer?) exact-integer?)
  (let loop ([left 0] [right 0] [sum 0] [min-length +inf.0])
    (cond
      [(>= right (length nums))
       (if (= min-length +inf.0) 0 min-length)]
      [else
       (let* ([new-sum (+ sum (list-ref nums right))]
         (if (< new-sum target)
             (loop left (+ right 1) new-sum min-length)
             (let ([new-min (min min-length (+ (- right left) 1))])
               (if (= left right)
                   (loop (+ left 1) (+ right 1) 0 new-min)
                   (loop (+ left 1) right (- new-sum (list-ref nums left)) new-min)))))])))