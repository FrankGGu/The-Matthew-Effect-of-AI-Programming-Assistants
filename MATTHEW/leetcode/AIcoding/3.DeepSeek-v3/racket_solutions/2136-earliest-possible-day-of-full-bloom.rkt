(define/contract (earliest-full-bloom plant-time grow-time)
  (-> (listof exact-integer?) (listof exact-integer?) exact-integer?)
  (define pairs (sort (map cons plant-time grow-time) 
                      (lambda (a b) (> (cdr a) (cdr b)))))
  (let loop ([pairs pairs] [current-time 0] [max-time 0])
    (if (null? pairs)
        max-time
        (let* ([pair (car pairs)]
               [p (car pair)]
               [g (cdr pair)]
               [new-current (+ current-time p)]
               [new-max (max max-time (+ new-current g))])
          (loop (cdr pairs) new-current new-max)))))