(define/contract (num-rescue-boats people limit)
  (-> (listof exact-integer?) exact-integer? exact-integer?)
  (let loop ([people (sort people <)]
             [boats 0])
    (cond
      [(empty? people) boats]
      [(empty? (rest people)) (add1 boats)]
      [else
       (let* ([heaviest (last people)]
              [lightest (first people)]
              [remaining (drop-right (rest people) 1)])
         (if (<= (+ heaviest lightest) limit)
             (loop remaining (add1 boats))
             (loop (drop-right people 1) (add1 boats))))])))