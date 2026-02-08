(define (total-fruit fruits)
  (define (helper start end basket1 basket2 count max-count)
    (cond
      [(>= end (length fruits)) max-count]
      [(or (null? basket1) (= (list-ref fruits end) basket1))
       (helper start (+ end 1) basket1 basket2 (+ count 1) (max max-count (+ count 1)))]
      [(or (null? basket2) (= (list-ref fruits end) basket2))
       (helper start (+ end 1) basket1 basket2 (+ count 1) (max max-count (+ count 1)))]
      [else
       (helper (+ start 1) (+ start 1) (list-ref fruits (+ start 1)) null 1 max-count)]))

  (if (null? fruits)
      0
      (helper 0 0 (list-ref fruits 0) null 0 0)))