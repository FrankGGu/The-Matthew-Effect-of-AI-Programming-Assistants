(define (find-the-winning-player coins k)
  (let loop ([players (for/list ([i (in-range (length coins))])
                        (list (list-ref coins i) i))]
             [round 1])
    (cond
      [(= round k) (second (car players))]
      [(> (first (car players)) (first (cadr players)))
       (loop (append (list (car players)) (cddr players)) (add1 round))]
      [else
       (loop (append (cdr players) (list (cadr players))) (add1 round))])))