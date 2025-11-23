(define/contract (min-positive-sum nums)
  (-> (listof exact-integer?) exact-integer?)
  (let loop ([i 0] [min-sum +inf.0] [current-sum 0] [min-positive +inf.0])
    (cond
      [(= i (length nums)) 
       (if (= min-positive +inf.0) -1 min-positive)]
      [else
       (let* ([num (list-ref nums i)]
              [new-sum (+ current-sum num)]
              [new-min-positive (if (and (> new-sum 0) (< new-sum min-positive))
                                   new-sum
                                   min-positive)])
         (if (< new-sum 0)
             (loop (add1 i) min-sum 0 new-min-positive)
             (loop (add1 i) min-sum new-sum new-min-positive)))])))