(define (maximize-score-of-numbers-in-ranges nums k)
  (let* ([n (vector-length nums)]
         [left k]
         [right k]
         [min-val (vector-ref nums k)]
         [max-score min-val])
    (let loop ()
      (cond
        [(and (> left 0) (< right (- n 1)))
         (cond
           [(> (vector-ref nums (- left 1)) (vector-ref nums (+ right 1)))
            (set! left (- left 1))
            (set! min-val (min min-val (vector-ref nums left)))]
           [else
            (set! right (+ right 1))
            (set! min-val (min min-val (vector-ref nums right)))])]
        [(> left 0)
         (set! left (- left 1))
         (set! min-val (min min-val (vector-ref nums left)))]
        [(< right (- n 1))
         (set! right (+ right 1))
         (set! min-val (min min-val (vector-ref nums right)))]
        [else
         (void)])
      (set! max-score (max max-score (* min-val (+ (- right left) 1))))
      (if (or (> left 0) (< right (- n 1)))
          (loop)
          max-score))))