(define (min-moves target maxDoubles)
  (let loop ((current target) (doubles maxDoubles) (moves 0))
    (cond
      [(= current 1) moves]
      [(> doubles 0)
       (if (even? current)
           (loop (/ current 2) (- doubles 1) (+ moves 1))
           (loop (- current 1) doubles (+ moves 1)))]
      [else (+ moves (- current 1))])))