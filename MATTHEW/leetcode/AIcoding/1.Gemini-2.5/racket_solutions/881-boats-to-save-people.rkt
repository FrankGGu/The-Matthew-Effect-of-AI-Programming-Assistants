(define (num-boats people limit)
  (let* ([sorted-people (sort people <)]
         [n (length sorted-people)]
         [people-vec (list->vector sorted-people)])
    (let loop ([left 0]
               [right (- n 1)]
               [boats 0])
      (cond
        [(> left right) boats]
        [else
         (let ([current-boats (+ boats 1)])
           (if (<= (+ (vector-ref people-vec left) (vector-ref people-vec right)) limit)
               (loop (+ left 1) (- right 1) current-boats)
               (loop left (- right 1) current-boats)))]))))