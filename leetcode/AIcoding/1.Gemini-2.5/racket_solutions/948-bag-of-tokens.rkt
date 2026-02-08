(define (bag-of-tokens tokens power)
  (let* ([n (length tokens)]
         [sorted-tokens (if (zero? n)
                            #[]
                            (vector-sort < (list->vector tokens)))]
         [left 0]
         [right (if (zero? n) -1 (sub1 n))])
    (let loop ([current-power power]
               [current-score 0]
               [max-score 0]
               [l left]
               [r right])
      (cond
        [(> l r) max-score]
        [(>= current-power (vector-ref sorted-tokens l))
         (loop (- current-power (vector-ref sorted-tokens l))
               (add1 current-score)
               (max max-score (add1 current-score))
               (add1 l)
               r)]
        [(and (> current-score 0) (< l r))
         (loop (+ current-power (vector-ref sorted-tokens r))
               (sub1 current-score)
               max-score
               l
               (sub1 r))]
        [else
         max-score]))))