(define/contract (count-students students sandwiches)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (let loop ([st students] [sa sandwiches] [count 0])
    (cond
      [(empty? st) 0]
      [(empty? sa) (length st)]
      [(= (first st) (first sa)) (loop (rest st) (rest sa) 0)]
      [else
       (if (= count (length st))
           (length st)
           (loop (append (rest st) (list (first st))) sa (add1 count))))])))