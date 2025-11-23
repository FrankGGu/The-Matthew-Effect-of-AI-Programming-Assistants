(define/contract (find-min-cost nums x)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([nums nums] [cost 0] [i 0])
    (cond
      [(null? nums) cost]
      [(= (length nums) 1) (+ cost (car nums))]
      [else
       (let* ([first-elem (car nums)]
              [last-elem (last nums)]
              [remove-first (+ cost (car nums) (* x i))]
              [remove-last (+ cost (last nums) (* x (- (length nums) 1 i)))])
         (if (<= first-elem last-elem)
             (loop (cdr nums) remove-first (add1 i))
             (loop (drop-right nums 1) remove-last i)))])))